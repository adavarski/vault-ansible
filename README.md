# VAULT
Installs a three node cluster of HashiCorp Vault with RAFT Integrated Storage.
Can be run behind a load balancer.

## Certificates
Certificates were generated with Let's encrypt and need regular rotation. acme.sh to generate certs.

## Backup
Backup and restoration can be done on the command line with `vault operator raft snapshot save <snapshot_file>` and then it can be restored with `vault operator raft snapshot restore <snapshot_file>`.

## Connect to a server via SSH using Vault
Vault provides a function to sign a SSH certificate. The servers will validate the signed SSH certificate and allow entry if the certificate is known. To gain access to a server you will first create a SSH certificate and then use vault to sign your certificate.

```
ssh-keygen -t rsa -C "a.davarski@link.com"
vault write ssh/sign/user public_key=@$HOME/.ssh/id_rsa.pub
// Copy the returned key to ~/.ssh/id_rsa-cert.pub
nano ~/.ssh/id_rsa-cert.pub
chmod 0400 ~/.ssh/id_rsa-cert.pub

// Last but not least connect to the machine
ssh -i ~/.ssh/id_rsa -i ~/.ssh/id_rsa-cert.pub root@157.90.155.247

// Certificates expire after some hours so you need to run everything again. You do no need to create a new key though if you don't want to (therefore ssh-keygen is optional).
```
REF: 
- https://www.hashicorp.com/blog/managing-ssh-access-at-scale-with-hashicorp-vault
- https://learn.hashicorp.com/tutorials/vault/oidc-auth-azure?in=vault/auth-methods
