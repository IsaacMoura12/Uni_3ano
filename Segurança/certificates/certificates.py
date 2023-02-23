import re
from cryptography import x509
import click
import os
from datetime import datetime

def valid_cert_interval(cert):
    now = datetime.now()

    return cert.not_valid_before <= now <=cert.not_valid_after
        

def load_certificates_with_regex(data):

    s_delim = '-----END CERTIFICATE-----'
    e_delim = '-----BEGIN CERTIFICATE-----'
    regex = f'(' + s_delim + '.*?' + e_delim + ')'
    return re.findall(regex,data,re.DOTALL)
    

def system_certs(filename):
    with open(filename,'r') as f:
        system_certs = f.read()

    pem_certs = load_certificates_with_regex(system_certs)
    certs = {}

    for pem_cert in pem_certs:
        b_cert = bytes(pem_cert,'utf-8')
        k = x509.load_pem_x509_certificate(b_cert)
        certs[k.subject] = k
    return certs




def load_cert(filename):
    with open(filename, 'rb') as f:
        cert_file= f.read()

    return x509.load_pem_x509_certificate(cert_file)




@click.command()
@click.option('--certfile', required = True, help = 'Certificate to validate')

def main(certfile):
    s_certs = system_certs('certs/system-certs.cer')

    if not os.path.exists(certfile):
        print('Certificate not found.')
        exit(1)
    cert = load_cert(certfile)
    print(cert)

    systemcerts = open('certificate.txt', 'r')


if __name__ == '__main__':
    main()

