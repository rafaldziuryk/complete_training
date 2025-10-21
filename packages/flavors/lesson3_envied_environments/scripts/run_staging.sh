#!/bin/bash
# scripts/run_staging.sh

echo "🚀 Running Flutter app in STAGING mode with Envied..."
flutter run --dart-define=ENVIRONMENT=staging
