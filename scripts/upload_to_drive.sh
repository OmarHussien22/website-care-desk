#!/bin/bash

set -e

FILE_PATH="$1"
FILE_NAME=$(basename "$FILE_PATH")

echo "Uploading $FILE_NAME to Google Drive..."

curl -X POST -L \
  -H "Authorization: Bearer $GOOGLE_DRIVE_ACCESS_TOKEN" \
  -F "metadata={name :\"$FILE_NAME\"};type=application/json;charset=UTF-8" \
  -F "file=@\"$FILE_PATH\";type=application/vnd.android.package-archive" \
  "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart"

echo "✅ Successfully uploaded $FILE_NAME to Google Drive!"
