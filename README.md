# Use Flux with this repo


1. Install Crossplane

2.1 Crossplane System via Helm

2.2 Crossplane providers via XP CLI

Flux will do a dry-run which fails as the Provider's ProviderConfig cannot be installed immediately after the Provider.
It needs some time. Workaround: install the Provider manually:
```
kubectl crossplane install provider crossplane/provider-helm:master
```

2. Install Flux
