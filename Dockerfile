FROM        ubuntu:14.04
MAINTAINER  Anthony Miyaguchi <amiyaguchi@mozilla.com>

WORKDIR     /tmp

# Add the upload script
ADD         bin /tmp/bin         
RUN         chmod +x /tmp/bin/*

# Define the environmental variables for the scripts
ENV         SOCORRO_SYMBOL_UPLOAD_TOKEN_FILE ./socorro_token
RUN         touch socorro_token

# Install dependencies
RUN         apt-get update
RUN         apt-get install -y python python-pip curl
RUN         pip install redo requests

# Default command
CMD         ["/bin/bash", "--login"]
