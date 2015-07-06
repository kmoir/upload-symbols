# Upload Symbols
Docker worker to upload crashreporter symbols as a separate taskcluster task.

## Building
`$ docker build -t upload_symbols .`

`$ docker run -i -t upload_symbols`

Then from inside the container, run:

`$ ./bin/upload.sh`

In order to run the `upload_symbols.py` script properly, the Dockerfile expects  a text file `socorro_token` embedded with the api token at the root directory before.

