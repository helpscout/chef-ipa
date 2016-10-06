# ipa cookbook

## Description

This cookbook provides custom resources and recipes to install and configure
[FreeIPA](https://www.freeipa.org/)

## Dependencies

### Platforms

* Ubuntu 14.04 - Client Only
* Ubuntu 16.04 - Client or Replica

Theoretically supported, but untested:

* CentOS 7+   - Client Only
* CentOS 7.3+ - Client or Replica

### Chef

* 12.5+

## Recipes

### ipa::default

This recipe includes either `ipa::client` or `ipa::replica` based on
`node['ipa']['role']`

### ipa::client

Installs the IPA client packages, then joins an existing realm.

### ipa::replica

Installs the IPA server packages, then joins and creates a replica of an
existing realm.

### ipa::bootstrap

Installs the IPA server packages, then creates a new realm.

### TODO
## Custom Resources

### Request a Certificate

```ruby
ipa_certificate 'rabbitmq-cert' do
end
```

### Request a Keytab

```ruby
ipa_keytab 'nginx-keytab' do
end
```

## Workarounds
* Homedir Creation
* sssd [ssh] ca_db = /etc/ipa/nssdb
