import os
import sys
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes


def File(filename):
    file = open(filename, "rb")
    data = file.read()
    file.close()
    return data


def encrypt(data):
    key = os.urandom(32)
    iv = os.urandom(16)
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
    encryptor = cipher.encryptor()
    ct = encryptor.update(data) + encryptor.finalize()
    decryptor = cipher.decryptor()
    decryptor.update(ct) + decryptor.finalize()

    decoded = decryptor.update(ct) + decryptor.finalize()
    return ct, decoded,iv,key
    



def main():

    File("cifra.txt")
    encrypt(File("cifra.txt"))