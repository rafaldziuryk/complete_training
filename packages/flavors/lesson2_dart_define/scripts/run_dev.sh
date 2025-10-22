#!/bin/bash
# scripts/run_dev.sh

echo "🚀 Running Flutter app in DEVELOPMENT mode..."
flutter run --dart-define=ENVIRONMENT=dev \
            --dart-define=APP_NAME="Flavors Demo - DEV" \
            --dart-define=API_BASE_URL=https://api-dev.example.com \
            --dart-define=ENABLE_LOGGING=true \
            --dart-define=ANALYTICS_ENABLED=true \
            --dart-define=CRASHLYTICS_ENABLED=true \
            --dart-define=DEBUG_MENU_ENABLED=true \
            --dart-define=FEATURE_FLAGS_ENABLED=true
