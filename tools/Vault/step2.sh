# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dev-server
{
    vault server -help

    vault server -dev

    export VAULT_ADDR='http://127.0.0.1:8200'

    export VAULT_TOKEN="hvs.6j4cuewowBGit65rheNoceI7"

    vault status
}