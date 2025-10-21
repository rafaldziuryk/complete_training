#!/bin/bash
# scripts/run_prod.sh

echo "🚀 Running Flutter app in PRODUCTION mode..."
flutter run --dart-define=ENVIRONMENT=prod \
            --dart-define=APP_NAME="Flavors Demo - PROD" \
            --dart-define=API_BASE_URL=https://api.example.com \
            --dart-define=ENABLE_LOGGING=false \
            --dart-define=ANALYTICS_ENABLED=true \
            --dart-define=CRASHLYTICS_ENABLED=true \
            --dart-define=DEBUG_MENU_ENABLED=false \
            --dart-define=FEATURE_FLAGS_ENABLED=false
