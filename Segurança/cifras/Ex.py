
import os
import sys
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes





def encrypt(message, key, iv,algo = "AES"):
    symm_algo = None
    if algo == "AES":
        symm_algo = algorithms.AES(key)



    
    key = os.urandom(32)
    iv = os.urandom(16)
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
    encryptor = cipher.encryptor()
    ct = encryptor.update(message) + encryptor.finalize()
    decryptor = cipher.decryptor()
    decryptor.update(ct) + decryptor.finalize()

    decoded = decryptor.update(ct) + decryptor.finalize()
    return ct, decoded


def encrypt_sample(message):
    key = os.urandom(32)
    iv = os.urandom(16)
    return 



def main():
    

    print(sys.argv)
    


    if len(sys.argv) < 3:
        exit(1)

    filename = sys.argv[1]
    algo = sys.argv[2]


    print(f'Encrypting {filename} using {algo}')

    if not os.path.exists(filename):
        print("File not found")


    msg = b"a secret message"
    ct, dm = encrypt_sample(data)
    



main()