# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-first-secret
{
    vault kv -help 

    vault kv put -help

    vault kv put -mount=secret hello foo=world

    vault kv put -mount=secret hello foo=world excited=yes

    vault kv get -mount=secret hello

    vault kv get -mount=secret -field=excited hello

    vault kv get -mount=secret -format=json hello | jq -r .data.data.excited

    vault kv delete -mount=secret hello

    vault kv get -mount=secret hello

    vault kv undelete -mount=secret -versions=2 hello

    vault kv get -mount=secret hello
    
}