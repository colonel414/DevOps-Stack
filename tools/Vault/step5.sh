
{
    vault token create

    vault login

    vault token revoke s.iyNUhq8Ov4hIAx6snw5mB2nL

    vault auth enable github

    vault write auth/github/config organization=hashicorp

    vault auth list

    vault auth help github

    unset VAULT_TOKEN

    vault login -method=github

    vault login root

    vault token revoke -mode path auth/github

    vault auth disable github

    
}