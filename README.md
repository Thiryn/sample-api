# Sample API
This is a sample API and its kubernetes deployment.

## API
The API uses generated types from the openapi definition [api/api.openapi.yaml](api/api.openapi.yaml).
It only exposes one endpoint which lists objects from a public S3 bucket

## Deployment
### Minikube
You can use Minikube to deploy the application via helm:

1. Create the minikube cluster

This will also deploy the loadbalancer and configure it.

```shell
make minikube-start
```

2. Deploy API the chart 

```shell
make minikube-deploy
```

### DigitalOcean
1. Deploy API the chart

```shell
make deploy
```

2. Install Otomi

```shell
make do-install-otomi
```

