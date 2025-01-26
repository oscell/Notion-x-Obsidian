#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Arguments
OPP_NAME="$1"

# Check if the opp already exists
response=$(curl -s -X POST 'https://api.notion.com/v1/databases/'"$NOTION_PROJECTS_DATABASE_ID"'/query' \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H 'Notion-Version: 2022-06-28' \
  -H "Content-Type: application/json" \
  --data '{
    "filter": {
      "and": [
        {
          "property": "Type",
          "select": {
            "equals": "Opp"
          }
        },
        {
          "property": "Name",
          "title": {
            "equals": "'"$OPP_NAME"'"
          }
        }
      ]
    }
  }')

echo "$response"

# Check if the response contains any results
if echo "$response" | grep -q '"results":\[\]'; then
  echo "Opp does not exist."
  exit 0  # Success, opp does not exist
else
  echo "Opp already exists."
  exit 1  # Failure, opp exists
fi