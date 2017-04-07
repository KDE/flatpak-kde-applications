#!/bin/sh
# added for compatibility with flatpak-build-scripts

FILE=$1

APPID=`basename $FILE .json`

echo ========== Building $APPID ================
rm -rf app
flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of ${APPID}, `date`" ${EXPORT_ARGS-} app $FILE
