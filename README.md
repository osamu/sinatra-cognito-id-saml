# IAM ID Providerの設定
# Cognito ID Poolの作成
# Google Suiteの設定
# Sample Ruby Application
openssl req -x509 -nodes -newkey rsa:2048 -keyout localhost.pem -out localhost.crt  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

