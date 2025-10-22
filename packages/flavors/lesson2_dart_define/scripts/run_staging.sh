#!/bin/bash
# scripts/run_staging.sh

echo "🚀 Running Flutter app in STAGING mode..."
flutter run --dart-define=ENVIRONMENT=staging \
            --dart-define=APP_NAME="Flavors Demo - STAGING" \
            --dart-define=API_BASE_URL=https://api-staging.example.com \
            --dart-define=ENABLE_LOGGING=true \
            --dart-define=ANALYTICS_ENABLED=true \
            --dart-define=CRASHLYTICS_ENABLED=true \
            --dart-define=DEBUG_MENU_ENABLED=true \
            --dart-define=FEATURE_FLAGS_ENABLED=true
