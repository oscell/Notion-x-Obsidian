#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Opp
# @raycast.mode silent


# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Optional parameters:
# @raycast.icon 💰
# @raycast.argument1 {    "type": "text",    "placeholder": "Opp Name" }
# @raycast.argument2 {    "type": "dropdown",    "placeholder": "Select AE",    "data": [     { "title": "Amir Seoudy", "value": "Amir Seoudy" },     { "title": "Caolan McBreen", "value": "Caolan McBreen" },     { "title": "Colin Reingewirtz", "value": "Colin Reingewirtz" },     { "title": "Eduardo Capuano", "value": "Eduardo Capuano" },     { "title": "Elias Kharrat", "value": "Elias Kharrat" },     { "title": "Gibril Farah", "value": "Gibril Farah" },     { "title": "Labeed AhmadQamar", "value": "Labeed AhmadQamar" }   ] }
# @raycast.argument3 { "type": "text", "placeholder": "Website(s) Seperate by commas" }
# @raycast.packageName System

# Documentation:
# @raycast.description Set the Dock autohide
# @raycast.author Jelte Lagendijk
# @raycast.authorURL https://raycast.com/j3lte

# Arguments
OPP_NAME="$1"
AE_NAME="$2"
WEBSITES="$3"

echo "$OPP_NAME"
# Check if the opp exists by calling the first script
if ./check_opp_exists.sh "$OPP_NAME"; then
  echo "Creating new opp: $OPP_NAME, $AE_NAME, $WEBSITES"

  # Create the opp using the node script
  if ! node create_opp.js "$OPP_NAME" "$AE_NAME" "$WEBSITES" "yo"; then
    echo "Error: Failed to create opportunity."
    exit 1
  fi

  # Create the opp in Notion
  curl -X POST "https://api.notion.com/v1/pages" \
    -H "Authorization: Bearer $NOTION_API_KEY" \
    -H "Content-Type: application/json" \
    -H "Notion-Version: 2021-05-13" \
    -d '{
      "parent": {
        "database_id": "'"$NOTION_PROJECTS_DATABASE_ID"'"
      },
      "properties": {
        "Name": {
          "title": [
            {
              "text": {
                "content": "'"$OPP_NAME"'"
              }
            }
          ]
        },
        "Type": {
          "select": {
            "name": "Opp"
          }
        },
        "Related Area": {
          "relation": [{
            "id": "1806f7480e4180708a83f282f5c38a3e"
          }]
        },
        "Related Person": {
          "select": {
            "name": "'"$AE_NAME"'"
          }
        }
      }
    }'
else
  # echo "Opp already exists. Skipping creation."
  exit 0
fi