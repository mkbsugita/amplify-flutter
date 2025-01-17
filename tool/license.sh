#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

#
# Adds missing licenses to all relevant files. 
# 
# Use `-check` option to verify header presence.
#

set -eo pipefail

if ! command -v addlicense &>/dev/null ; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS=Linux
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS=macOS
    else
        echo "Unrecognized OS: $OSTYPE" >&2
        exit 1
    fi

    VERSION=1.1.0
    FILENAME=addlicense_${VERSION}_${OS}_x86_64.tar.gz
    CHECKSUMS=checksums.txt
    curl -L -o ${FILENAME} https://github.com/google/addlicense/releases/download/v${VERSION}/${FILENAME}
    curl -L -o ${CHECKSUMS} https://github.com/google/addlicense/releases/download/v${VERSION}/${CHECKSUMS}
    cat ${CHECKSUMS} | grep ${FILENAME} | shasum -a 256 -c -

    tar -xzf ${FILENAME}
    chmod +x addlicense
    mv addlicense /usr/local/bin
fi

addlicense -l apache \
    -c "Amazon.com, Inc. or its affiliates. All Rights Reserved." \
    -s=only \
    -y="" \
    -ignore '**/*.yaml' \
    -ignore '**/*.yml' \
    -ignore '**/amplifyconfiguration.dart' \
    -ignore 'tool/ci.sh' \
    -ignore '**/*.html' \
    -ignore '**/.dart_tool/**' \
    -ignore '**/build/**' \
    -ignore '**/*.g.dart' \
    -ignore '**/*.worker.dart' \
    -ignore '**/*.worker.*.dart' \
    -ignore '**/*.mocks.dart' \
    -ignore '**/*.js' \
    -ignore '**/version.dart' \
    -ignore '**/*.xml' \
    -ignore '**/GeneratedPluginRegistrant.java' \
    -ignore '**/Runner-Bridging-Header.h' \
    -ignore '**/GeneratedPluginRegistrant.swift' \
    -ignore '**/generated_plugin_registrant.*' \
    -ignore '**/Pods/**' \
    -ignore '**/*.debug.dart' \
    -ignore '**/*.release.dart' \
    -ignore '**/goldens/**' \
    -ignore '**/node_modules/**' \
    -ignore '**/sdk/**' \
    -ignore '**/external/**' \
    -ignore "**/generated_plugins.cmake" \
    -ignore "**/CMakeLists.txt" \
    -ignore "**/linux/runner/**" \
    -ignore "**/windows/runner/**" \
    -ignore "**/windows/flutter/**" \
    -ignore "**/amplify/**" \
    $@ $PWD
