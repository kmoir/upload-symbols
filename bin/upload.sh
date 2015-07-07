#! /bin/bash

CRASH_SYMBOL_ZIP=crashreporter-symbols.zip
UPLOAD_SCRIPT=upload_symbols.py

# Check that we have a taskid to checkout
if [ -z ${ARTIFACT_TASKID} ]; then
    echo "Please set ARTIFACT_TASKID. Exiting"
    exit 0
fi

# grab the symbols from an arbitrary task
curl -o ${CRASH_SYMBOL_ZIP} https://queue.taskcluster.net/v1/task/${ARTIFACT_TASKID}/artifacts/public/build/target.crashreporter-symbols.zip

# download the script and the patch
curl -o ${UPLOAD_SCRIPT} http://mxr.mozilla.org/mozilla-central/source/toolkit/crashreporter/tools/upload_symbols.py?raw=1
curl -o fallback.patch https://bug1168979.bugzilla.mozilla.org/attachment.cgi?id=8628990
patch < fallback.patch

# run
python -u ${UPLOAD_SCRIPT} ${CRASH_SYMBOL_ZIP}
