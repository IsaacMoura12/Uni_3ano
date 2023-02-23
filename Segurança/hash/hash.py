import click
import os
from cryptography.hazmat.primitives import hashes




def hash_data(data):
    digest = hashes.Hash(hashes.SHA256())
    digest.update(data)
    return digest.finalize()


def flip_bit(data,bit_n):
    adata = bytearray(data)
    offset = int(bit_n/8)
    bit_offset = bit_n % 8
    if len(adata) <= offset:
        return adata

    adata[offset] = adata[offset] ^ (0x80 >> bit_offset)
    return adata

@click.command()
@click.option('--filename',required =True, help = "File to be hashed.")
@click.option('--n',required =True, help = "Bit to flip.")




def main(filename,n):
    if not os.path.exists(filename):
        print("No such file or directory.")
        exit(1)

    with open(filename, "rb") as f:
        data = f.read()



    h1 = hash_data(data)
    h2 = hash_data(flip_bit(data))
    print(h1.hex())
    print(h2.hex())




    

        #h1 = hash_data(data)
        #h2 = hash_data(flip_bit(data))
        #print(h1.hex())
        #print(h2.hex())
    


if __name__== '__main__':
    main()