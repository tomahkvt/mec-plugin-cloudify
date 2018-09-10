#!/bin/bash
shopt -s extglob
PLUGIN_NAME=mec-plugin-cloudify
PLUGIN_TAG_NAME=0.0.3
PLUGIN_NAME_=${PLUGIN_NAME//-/_}
if [ -d "$PLUGIN_NAME-$PLUGIN_TAG_NAME" ]; then
  rm -r "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
fi
mkdir "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r build "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r constraints.txt "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r dev-requirements.txt "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r dist "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r plugin.yaml "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r setup.py "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
cp -r *.egg-info "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
mkdir "$PLUGIN_NAME-$PLUGIN_TAG_NAME/$PLUGIN_NAME_"
if [ -d "$PLUGIN_NAME_" ]; then
  rm -r "$PLUGIN_NAME_"
fi
mkdir "$PLUGIN_NAME_"
cd plugin
cp !(tests) "../$PLUGIN_NAME-$PLUGIN_TAG_NAME/$PLUGIN_NAME_"
cp !(tests) "../$PLUGIN_NAME_"

cd ../
if [ -f "$PLUGIN_NAME-$PLUGIN_TAG_NAME" ]; then
  rm "$PLUGIN_NAME-$PLUGIN_TAG_NAME"
fi

tar -cvzf "$PLUGIN_TAG_NAME.tar.gz" "$PLUGIN_NAME-$PLUGIN_TAG_NAME"

if [ -f "$PLUGIN_NAME.zip" ]; then
  rm "$PLUGIN_NAME.zip"
fi


zip "$PLUGIN_NAME.zip" $PLUGIN_NAME_
zip "$PLUGIN_NAME.zip" dev-requirements.txt
zip "$PLUGIN_NAME.zip" plugin.yaml
zip "$PLUGIN_NAME.zip" setup.py
