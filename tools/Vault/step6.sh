# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-policies
{
    vault policy read default

    vault policy write -h

    vault policy write my-policy - <<EOF
    # Dev servers have version 2 of KV secrets engine mounted by default, so will
    # need these paths to grant permissions:
    path "secret/data/*" {
      capabilities = ["create", "update"]
    }

    path "secret/data/foo" {
      capabilities = ["read"]
    }
EOF

    vault policy list

    vault policy read my-policy

    export VAULT_TOKEN="$(vault token create -field token -policy=my-policy)"

    vault token lookup | grep policies

    export VAULT_TOKEN=root

    vault auth list | grep 'approle/'

    
}
