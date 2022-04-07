# DAPS-https
Temporary DAPS for Clearing House testing.

## System
### /etc/idscert/localhost

Add the following files from MobilityDataSpace/Certificates/TLS
```
omejdn.crt
omejdn.key
```

## Omejdn DAPS

DAPS reverseproxy
```
cd nginx
docker build -t daps-reverseproxy .

```

DAPS server image
```
docker build -t daps .
```

Launch the component
```
docker-compose up
```

## Dataspace Connector
### Application.properties

```
daps.url=https://omejdn
daps.token.url=https://omejdn/token
daps.key.url=https://omejdn/.well-known/jwks.json
daps.key.url.kid={'https://omejdn/.well-known/jwks.json':'default'}
```

