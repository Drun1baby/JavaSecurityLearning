from email.mime import base
from pydoc import plain
import sys
import base64
from turtle import mode
import uuid
from random import Random
from Crypto.Cipher import AES

def get_file_data(filename):
    with open(filename, 'rb') as f:
        data = f.read()
    return data

def aes_enc(data):
    BS = AES.block_size
    pad = lambda s: s + ((BS - len(s) % BS) * chr(BS - len(s) % BS)).encode()
    key = "kPH+bIxk5D2deZiIxcaaaA=="
    mode = AES.MODE_CBC
    iv = uuid.uuid4().bytes
    encryptor = AES.new(base64.b64decode(key), mode, iv)
    ciphertext = base64.b64encode(iv + encryptor.encrypt(pad(data)))
    return ciphertext

def aes_dec(enc_data):
    enc_data = base64.b64decode(enc_data)
    unpad = lambda s: s[:-s[-1]]
    key = "kPH+bIxk5D2deZiIxcaaaA=="
    mode = AES.MODE_CBC
    iv = enc_data[:16]
    encryptor = AES.new(base64.b64decode(key), mode, iv)
    plaintext = encryptor.decrypt(enc_data[16:])
    plaintext = unpad(plaintext)
    return plaintext

if __name__ == "__main__":
    data = get_file_data("ser.bin")
    print(aes_enc(data))