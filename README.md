# RabbitMQ on-startup configurable

## Building and running your container
### Building image
```sh
docker image build -t my-rabbitmq .
```

### Running your newly created image
```sh
docker container run --rm -h my-rabbit -p 15672:15672 -p 5672:5672 -e RABBITMQ_USER=myuser -e RABBITMQ_PASSWORD=mystrongpassword my-rabbitmq
```

- `--rm`: Remove container when it stops running.
- `-h my-rabbit': This should be specified explicitly for each daemon so that RabbitMQ can keep track of its data.
- `-p 5672:5672`: Port 5672 is where the queue is listening on.
- `-p 15672:15672`: Port where the management UI is accessible.
- `-e RABBITMQ_USER=myuser`: The user that will be created and granted admin privileges at startup.
- `-e RABBITMQ_PASSWORD=mystrongpassword`: The password used by the user `myuser` at startup.
- `my-rabbitmq`: The image name given at [Building image](#building-image).

## Changing the definitions

RabbitMQ accepts a json file with the definitions to be used for configuring itself.
To customize your definitions, just change the file `definitions.json`.

See example below:
```json
{
  "users": [{
    "name": "admin",
    "password": "qweqweqwe",
    "tags": "administrator"
  }, {
    "name": "consumer",
    "password": "qweqwe",
    "tags": ""
  }],
  "vhosts": [{
    "name": "/"
  }],
  "permissions": [{
    "user": "admin",
    "vhost": "/",
    "configure": ".*",
    "write": ".*",
    "read": ".*"
  }, {
    "user": "consumer",
    "vhost": "/",
    "configure": "",
    "write": "",
    "read": ".*"
  }],
  "exchanges": [{
    "name": "example-exchange",
    "vhost": "/",
    "type": "direct",
    "durable": true,
    "auto_delete": false,
    "internal": false,
    "arguments": {}
  }],
  "queues": [{
    "name": "example-queue",
    "vhost": "/",
    "durable": true,
    "auto_delete": false,
    "arguments": {
      "x-message-ttl": 3600000
    }
  }],
  "bindings": [{
    "source": "example-exchange",
    "vhost": "/",
    "destination": "example-queue",
    "destination_type": "queue",
    "routing_key": "route_to_everybody",
    "arguments": {}
  }]
}
```
