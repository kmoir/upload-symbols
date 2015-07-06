FROM        ubuntu:14.04
MAINTAINER  Anthony Miyaguchi <amiyaguchi@mozilla.com>

WORKDIR     /tmp

# Add the upload script
ADD         bin /tmp/bin         
RUN         chmod +x /tmp/bin/*

# Define the environmental variables for the scripts
COPY        socorro_token   /tmp/
ENV         ARTIFACT_TASKID hPJSOfAmSt6F6xJDKU7exg 
ENV         SOCORRO_SYMBOL_UPLOAD_TOKEN_FILE /tmp/socorro_token

# Install dependencies
RUN         apt-get update
RUN         apt-get install -y python python-pip curl
RUN         pip install redo requests

# Default command
CMD         ["/bin/bash", "--login"]
