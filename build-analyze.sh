#!/bin/bash

# SonarCloud needs a full clone to work correctly but some CIs perform shallow clones
# so we first need to make sure that the source repository is complete
# git fetch --unshallow

SONAR_HOST_URL=https://sonarcloud.io
#SONAR_TOKEN= # Access token coming from SonarCloud projet creation page. In this example, it is defined in the environement through a Github secret.
export SONAR_SCANNER_VERSION="4.8.0.2856" # Find the latest version in the "Linux" link on this page:
                                          # https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/sonarscanner-cli/
export BUILD_WRAPPER_OUT_DIR="$(mktemp -d)" # Directory where build-wrapper output will be placed

mkdir $HOME/.sonar

# Download build-wrapper
curl -sSLo $HOME/.sonar/build-wrapper-linux-x86.zip https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -o $HOME/.sonar/build-wrapper-linux-x86.zip -d $HOME/.sonar/
export PATH=$HOME/.sonar/build-wrapper-linux-x86:$PATH

# Download sonar-scanner
curl -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip 
unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
export PATH=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin:$PATH

# Setup the build system
autoreconf --install
./configure

# Build inside the build-wrapper
build-wrapper-linux-x86-64 --out-dir $BUILD_WRAPPER_OUT_DIR make clean all

# Run sonar scanner
sonar-scanner -X -Dsonar.host.url="${SONAR_HOST_URL}" -Dsonar.login=$SONAR_TOKEN -Dsonar.cfamily.build-wrapper-output=$BUILD_WRAPPER_OUT_DIR
