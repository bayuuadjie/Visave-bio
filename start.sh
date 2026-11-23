#!/bin/sh
cd "$(dirname "$0")"
mkdir -p libs
get(){ [ -f "libs/$1" ] || curl -sL "$2" -o "libs/$1"; }
get pdf.min.js https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js
get pdf.worker.min.js https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js
get jszip.min.js https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js
if command -v python3 >/dev/null; then python3 serve.py; else node server.js; fi
