#!/bin/bash

set -e

DIST_DIR='distribution/target'

druid_version=`ls $DIST_DIR/druid-*tar.gz | sed 's/.*\(druid-.*\)-.*/\1/g'`
test -d ${druid_version} && rm -rf ${druid_version}
tar zxvf $DIST_DIR/${druid_version}-bin.tar.gz
mkdir -p ${druid_version}/config/pull-deps/
cp pull-deps.runtime.properties ${druid_version}/config/pull-deps/common.runtime.properties
pushd ${druid_version}
java -Ddruid.extensions.localRepository=./extensions -classpath ./config/pull-deps:lib/* io.druid.cli.Main tools pull-deps
popd
tar zcvf ${druid_version}-sps-bin.tar.gz ${druid_version}/
