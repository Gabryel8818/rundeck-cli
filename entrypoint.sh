#!/bin/bash

export RD_AUTH_PROMPT=false
FILE=$(echo $FILE | tr -d '"')
rd jobs load  -F yaml -f "./$FILE" -p "$PROJECT"
