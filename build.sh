#!/bin/bash

FILE=$1

shift

ID=
JSON=
GITURL=
GITBRANCH=master

. ./$FILE

if [ x$ID == x ]; then
    echo invalid app
    exit 1
fi

GIT_ARGS=""
if [ x$GITURL != x ]; then
    GIT_ARGS="--from-git=$GITURL --from-git-branch=$GITBRANCH"
fi

flatpak-builder --force-clean --ccache --require-changes --repo=repo --subject="Build of ${ID}, `date`" ${EXPORT_ARGS-} ${GIT_ARGS-} "$@" app $JSON
