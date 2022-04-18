#! /bin/bash
read -p 'Enter DNS or IP: ' dnsname
echo "Generating certificates for '$dnsname'"

sed "s/@dnsname/$dnsname/g" ca-template.conf > ca.conf
sed "s/@dnsname/$dnsname/g" cert-template.conf > cert.conf
sed "s/@dnsname/$dnsname/g" csr-template.conf > csr.conf

mkdir certs

echo "Generating CA private key: ca-key.pem"
openssl genrsa 2048 > certs/ca-key.pem

echo "Generating CSR private key: server-req.pem"
openssl genrsa 2048 > certs/server-key.pem

echo "Generating CA certificate: ca-cert.pem"
openssl req -new -x509 -nodes -days 365000 \
   -key certs/ca-key.pem \
   -out certs/ca-cert.pem \
   -config ca.conf
   
echo "Generating CSR certificate: server-req.pem"
openssl req -newkey rsa:2048 -nodes -days 365000 -sha256 \
   -keyout certs/server-key.pem \
   -out certs/server-req.pem \
   -config csr.conf
   
echo "Generating server certificate: server-cert.pem"
openssl x509 -req -days 365000 -set_serial 01 -sha256 \
   -in certs/server-req.pem \
   -out certs/server-cert.pem \
   -CA certs/ca-cert.pem \
   -CAkey certs/ca-key.pem \
   -extfile cert.conf

rm ca.conf
rm cert.conf
rm csr.conf
