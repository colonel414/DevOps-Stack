# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-secrets-engines
{
    vault kv put foo/bar a=b

    vault secrets enable -path=kv kv

    vault secrets enable kv

    vault secrets list

    vault kv get kv/hello

    vault kv put kv/my-secret value="s3c(eT"

    vault kv list kv/

    vault secrets disable kv/
}