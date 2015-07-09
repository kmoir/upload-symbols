#! /bin/bash

UPLOAD_SCRIPT=upload_symbols.py

# Check that we have a taskid to checkout
if [ -z ${ARTIFACT_TASKID} ]; then
    echo "Please set ARTIFACT_TASKID. Exiting"
    exit 0
fi

# grab the symbols from an arbitrary task
symbol_url=https://queue.taskcluster.net/v1/task/${ARTIFACT_TASKID}/artifacts/public/build/target.crashreporter-symbols.zip
symbol_zip=$(basename ${symbol_url})
curl ${symbol_url}

# download the script and the patch
curl -o ${UPLOAD_SCRIPT} http://mxr.mozilla.org/mozilla-central/source/toolkit/crashreporter/tools/upload_symbols.py?raw=1
curl -o fallback.patch https://bug1168979.bugzilla.mozilla.org/attachment.cgi?id=8628990
patch < fallback.patch

# run
python -u ${UPLOAD_SCRIPT} ${symbol_zip}
