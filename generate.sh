#! /bin/bash
read -p 'Enter DNS or IP: ' dnsname
echo "Generating certificates for '$dnsname'"

sed -i "" "s/@dnsname/$dnsname/g" ca.conf
sed -i "" "s/@dnsname/$dnsname/g" cert.conf

echo "Generating CA private key: ca-key.pem"
openssl genrsa 2048 > ca-key.pem

echo "Generating CSR private key: server-req.pem"
openssl genrsa 2048 > server-key.pem

echo "Generating CA certificate: ca-cert.pem"
openssl req -new -x509 -nodes -days 365000 \
   -key ca-key.pem \
   -out ca-cert.pem \
   -config ca.conf
   
echo "Generating CSR certificate: server-req.pem"
openssl req -newkey rsa:2048 -nodes -days 365000 -sha256 \
   -keyout server-key.pem \
   -out server-req.pem \
   -config csr.conf
   
echo "Generating server certificate: server-cert.pem"
openssl x509 -req -days 365000 -set_serial 01 -sha256 \
   -in server-req.pem \
   -out server-cert.pem \
   -CA ca-cert.pem \
   -CAkey ca-key.pem \
   -extfile cert.conf

sed -i "" "s/$dnsname/@dnsname/g" ca.conf
sed -i "" "s/$dnsname/@dnsname/g" cert.conf