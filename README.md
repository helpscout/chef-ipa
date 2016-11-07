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

```ruby
ipa_certificate 'rabbitmq-cert' do
  key_path  '/etc/ssl/private/rabbitmq.key'
  cert_path '/etc/ssl/certs/rabbitmq.crt'
end
```
