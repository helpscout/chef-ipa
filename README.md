# ipa cookbook

## Description

This cookbook provides custom resources and recipes to install and configure
[FreeIPA](https://www.freeipa.org/)

## Dependencies

### Platforms

* Ubuntu 14.04 - Client Only
* Ubuntu 16.04 - Client or Replica
* CentOS 6  - Client Only
* CentOS 7 - Client Only


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
* pem_cert
* pem_cert_owner
* pem_cert_group
* pem_cert_mode
* pem_key
* pem_key_owner
* pem_key_group
* pem_key_mode
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
```

```ruby
ipa_certificate 'fqdn-cert-rabbitmq' do
  pem_cert       '/etc/rabbitmq/fqdn-cert-rabbitmq.crt'
  pem_cert_owner 'rabbitmq'
  pem_cert_group 'rabbitmq'
  pem_cert_mode  '0655'
  pem_key        '/etc/rabbitmq/fqdn-cert-rabbitmq.key'
  pem_key_owner  'rabbitmq'
  pem_key_group  'rabbitmq'
  pem_key_mode   '0660'
  req_subject    node['fqdn']
  req_principal  "host/#{node['fqdn']}"
end
```
