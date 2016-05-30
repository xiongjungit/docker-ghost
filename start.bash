#!/bin/bash

GHOST="/ghost"

CONFIG="config.js"
DATA="content/data"
IMAGES="content/images"
THEMES="content/themes"


# Start Ghost
chown -R ghost:ghost /ghost
su ghost << EOF
cd "$GHOST"
NODE_ENV=${NODE_ENV:-production} npm start
EOF
