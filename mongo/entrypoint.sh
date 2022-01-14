#!/usr/bin/env bash
set -eE -o pipefail

mongo $MONGO_INITDB_DATABASE mongo-init.js

