#!/bin/bash

# FKappa Framework - Flavor Build Script

COMMAND=$1
FLAVOR=$2

if [ -z "$COMMAND" ] || [ -z "$FLAVOR" ]; then
    echo "Usage: ./build_flavors.sh [run|build] [dev|staging|prod]"
    exit 1
fi

case $FLAVOR in
  dev)
    ENTRY_POINT="lib/main_dev.dart"
    ;;
  staging)
    ENTRY_POINT="lib/main_staging.dart"
    ;;
  prod)
    ENTRY_POINT="lib/main_prod.dart"
    ;;
  *)
    echo "Unknown flavor: $FLAVOR"
    exit 1
    ;;
esac

echo "🚀 Executing $COMMAND for flavor: $FLAVOR using $ENTRY_POINT..."

if [ "$COMMAND" == "run" ]; then
    flutter run -t $ENTRY_POINT --flavor $FLAVOR
elif [ "$COMMAND" == "build" ]; then
    # Add obfuscation for Production
    if [ "$FLAVOR" == "prod" ]; then
        echo "🔐 Building with Code Obfuscation..."
        flutter build apk -t $ENTRY_POINT --flavor $FLAVOR --obfuscate --split-debug-info=build/app/outputs/symbols
    else
        flutter build apk -t $ENTRY_POINT --flavor $FLAVOR
    fi
fi
