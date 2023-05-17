# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-deploy
{
    unset VAULT_TOKEN

    mkdir -p ./vault/data

    vault server -config=config.hcl

    export VAULT_ADDR='http://127.0.0.1:8200'

    vault operator init

    vault operator unseal

    vault login

    pgrep -f vault | xargs kill

    rm -r ./vault/data
}