#Step1
#Download harbor
{
    curl -s https://api.github.com/repos/goharbor/harbor/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep '\.tgz$' | wget -i -
}

#Unpack downloaded Harbor file
{
    tar xvzf harbor-offline-installer*.tgz
    cd harbor
}

--------------------------------

#Step2
#Harbor Installation with Self Signed SSL Certificates
#For Self signed certificates, create certificate configuration file
{
    $ cd /etc/pki/tls/certs
    $ sudo nano harbor_certs.cnf
    [ req ]
    default_bits = 4096
    default_md = sha512
    default_keyfile = harbor_registry.key
    prompt = no
    encrypt_key = no
    distinguished_name = req_distinguished_name

    # distinguished_name
    [ req_distinguished_name ]
    countryName = "UG"
    localityName = "Kampala"
    stateOrProvinceName = "Kampala"
    organizationName = "example example"
    commonName = "registry.example.com"
    emailAddress = "webmaster@example.com"
}

{
    #Generate key and csr
    sudo openssl req -out harbor_registry.csr -newkey rsa:4096 --sha512 -nodes -keyout harbor_registry.key -config harbor_certs.cnf

    #Create self-singed certificate with 10 years expiration date
    sudo openssl x509 -in harbor_registry.csr -out harbor_registry.crt -req -signkey harbor_registry.key -days 3650

    #To view certificate details use the command
    openssl x509 -text -noout -in harbor_registry.crt

    #Configure https related config
    hostname:
    harbor_admin_password:
    # Harbor DB configuration
    database:
    password:
    http:
    port: 80

    https:
    port: 443
    certificate: ./harbor_registry.crt
    private_key: ./harbor_registry.key
}

-----------------------------------------------------

#Install Harbor Docker image registry
{
    sudo ./install.sh --with-notary --with-chartmuseum --with-trivy

    sudo ./install.sh --help
}
