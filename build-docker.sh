#!/bin/bash

function exit9 {
echo "BEEEEEEEEEP $DOCKERFILE doesn't exist. Press Enter " && exit 9
}    
CURRENTVERSION=0
NEWVERSION=0
VERSIONNAME=v$NEWVERSION

DOCKERHUB=user
CUSER=user
CLOGIN=user@email.address
HOMEDIR=/
KEYNAME=PRIVATEKEYNAME.pem
KEYPATH=~/.ssh/PRIVATE_KEY_DOT_PEM

LOCALHOMESAFE=${HOMEDIR}\\/${CUSER}

VERSION=$NEWVERSION

if [ $# -eq 0 ];then APPS_LIST=(seed)
else APPS_LIST=$*;fi

for APP in ${APPS_LIST[@]};do

DOCKERFILE=Dockerfile.$APP
echo -e \\nreading $DOCKERFILE
if [ $VERSION -gt $CURRENTVERSION ];then TAGVERSION="-t $DOCKERHUB/$APP:$VERSIONNAME";fi
if [ ! -f $DOCKERFILE ];then exit9;fi
docker build $NOCACHE \
    --build-arg THISUSER=$CUSER \
    --build-arg HOMEDIR=$HOMEDIR \
    --build-arg LOCALHOMESAFE=$LOCALHOMESAFE \
    --build-arg gitlogin=$CLOGIN \
    --build-arg gituser=$CUSER \
    --build-arg SSH_PRIVATE_KEY=$KEYNAME \
    --secret id=$KEYNAME,src=$KEYPATH \
    --rm -f $DOCKERFILE -t $DOCKERHUB/$APP -t $DOCKERHUB/$APP:latest $TAGVERSION .
done

