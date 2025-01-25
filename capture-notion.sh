#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Notion Capture
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }
# @raycast.packageName Notion

# Documentation:
# @raycast.description test-command
# @raycast.author oscell
# @raycast.authorURL https://raycast.com/oscell

echo "Hello World! Argument1 value: "$1""

# Replace "test 123" with the argument value
curl -X POST "https://api.notion.com/v1/pages" \
  -H "Authorization: Bearer $NOTION_API_KEY" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2021-05-13" \
  -d '{
    "parent": {
      "database_id": "'"$NOTION_DATABASE_ID"'"
    },
    "properties": {
      "Name": {
        "title": [
          {
            "text": {
              "content": "'"$1"'"
            }
          }
        ]
      },
      "Description": {
        "rich_text": []
      }
    }
  }'