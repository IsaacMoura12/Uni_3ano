from Crypto.Cipher import AES
import hashlib
import os

password = os.random(32)
key = hashlib.sha256(password).digest()
mode = AES.MODE_CBC
IV = os.random(16)


cipher = AES.new(key,mode,IV)

def File(filename):
    file = open(filename, "rb")
    message = file.read()
    file.close()
    return message

def pad_message(message):

    while len(message) % 16 != 0:
        message1 = message + " "
        return message1



cipher = AES.new(key,mode,IV)

padded_message = pad_message(message1)

    