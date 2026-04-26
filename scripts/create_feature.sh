#!/bin/bash

# Script to create a new feature folder structure
# Usage: ./create_feature.sh <feature_name>

if [ -z "$1" ]; then
    echo "Usage: ./create_feature.sh <feature_name>"
    echo "Example: ./create_feature.sh profile"
    exit 1
fi

FEATURE_NAME=$1
BASE_PATH="lib/src/features/$FEATURE_NAME"

# Check if feature already exists
if [ -d "$BASE_PATH" ]; then
    echo "Error: Feature '$FEATURE_NAME' already exists at $BASE_PATH"
    exit 1
fi

echo "Creating feature: $FEATURE_NAME"

# Create core folders
mkdir -p "$BASE_PATH/core/params"
mkdir -p "$BASE_PATH/core/apis"
mkdir -p "$BASE_PATH/core/assets"

# Create data folders
mkdir -p "$BASE_PATH/data/data_sources"
mkdir -p "$BASE_PATH/data/models"

# Create domain folders
mkdir -p "$BASE_PATH/domain/entities"
mkdir -p "$BASE_PATH/domain/repos"
mkdir -p "$BASE_PATH/domain/use_cases"

# Create presentation folders
mkdir -p "$BASE_PATH/presentation/controllers"
mkdir -p "$BASE_PATH/presentation/pages"
mkdir -p "$BASE_PATH/presentation/widgets"

echo "Feature '$FEATURE_NAME' created successfully at $BASE_PATH"
echo ""
echo "Structure created:"
echo "$FEATURE_NAME/"
echo "├── core/"
echo "│   ├── params/"
echo "│   └── assets/"
echo "│   └── apis/"
echo "├── data/"
echo "│   ├── data_sources/"
echo "│   └── models/"
echo "├── domain/"
echo "│   ├── entities/"
echo "│   ├── repos/"
echo "│   └── usecases/"
echo "└── presentation/"
echo "    ├── controllers/"
echo "    ├── pages/"
echo "    └── widgets/"
