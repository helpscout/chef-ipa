# ipa cookbook

## Description

This cookbook provides custom resources and recipes to install and configure
[FreeIPA](https://www.freeipa.org/)

## Dependencies

### Platforms

* Ubuntu 14.04 - Client Only
* Ubuntu 16.04 - Client or Replica

### Chef

* 12.5+

## Recipes

### ipa::default

This recipe is an alias for ipa::client

### ipa::client

Installs the IPA client packages, then joins an existing realm.

### ipa::replica

Installs the IPA server packages, then joins and creates a replica of an
existing realm.

### ipa::bootstrap

Installs the IPA server packages, then creates a new realm.

### ipa::workarounds

This recipe deals with the brokenness of IPA on Debian/Ubuntu

### Request a Certificate

#### Actions
* request

#### Attributes
* nickname
* pem_ca
* pem_cert
* pem_key
* key_size
* auto_renew
* req_subject
* req_principal
* req_dns
* cmd_presave
* cmd_postsave

```ruby
ipa_certificate 'short-hostname-cert' do
  pem_cert  '/tmp/short-hostname-cert.crt'
  pem_key   '/tmp/short-hostname-cert.key''
end
```

```ruby
ipa_certificate 'fqdn-cert' do
  pem_cert      '/tmp/fqdn-cert.crt'
  pem_key       '/tmp/fqdn-cert.key'
  req_subject   node['fqdn']
  req_principal "host/#{node['fqdn']}"
end
