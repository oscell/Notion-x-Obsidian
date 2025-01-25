#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Opp
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 {    "type": "text",    "placeholder": "Opp Name" }
# @raycast.argument2 {    "type": "dropdown",    "placeholder": "Select AE",    "data": [     { "title": "Amir Seoudy", "value": "Amir Seoudy" },     { "title": "Caolan McBreen", "value": "Caolan McBreen" },     { "title": "Colin Reingewirtz", "value": "Colin Reingewirtz" },     { "title": "Eduardo Capuano", "value": "Eduardo Capuano" },     { "title": "Elias Kharrat", "value": "Elias Kharrat" },     { "title": "Gibril Farah", "value": "Gibril Farah" },     { "title": "Labeed AhmadQamar", "value": "Labeed AhmadQamar" }   ] }
# @raycast.argument3 { "type": "text", "placeholder": "Website(s) Seperate by commas" }
# @raycast.packageName System

# Documentation:
# @raycast.description Set the Dock autohide
# @raycast.author Jelte Lagendijk
# @raycast.authorURL https://raycast.com/j3lte

echo "Create Opp: $1, $2, $3"

if ! node create_opp.js "$1" "$2" "$3" "yo"; then
  echo "Error: Failed to create opportunity."
  exit 1
fi


