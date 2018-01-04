# YouPHPTube Dockerfiles
Docker files for development.

## Usage Examples

### To build the encoder
docker build -t encoder:1 .

### To run the encoder
docker run -i -t -p 127.0.0.2:80:80 encoder:1 /bin/bash

### To exit
exit