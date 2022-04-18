# cert-generator
`cert-generator` is a script to generate Self Signed x509 RSA SHA256 certificates using openssl in the backend.

This project generates these files:  
Root Private Key: `ca-key.pem`  
Root CA: `ca-cert.pem`  
  
Certificate Signing Request (CSR) Private Key: `server-key.pem`  
Certificate Signing Request (CSR): `server-req.pem`  
  
Certificate: `server-cert.pem`

## Usage
Open terminal and enter the following commands in order.
```bash
git clone github.com/yakuter/cert-generator
cd cert-generator
bash generate.sh
```

Resources:  
- [IBM Self Signed Cert Configuration](https://www.ibm.com/docs/en/ztpf/1.1.0.15?topic=gssccr-configuration-file-generating-self-signed-certificates-certificate-requests)