#!/bin/bash
# scripts/run_prod.sh

echo "🚀 Running Flutter app in PRODUCTION mode with Envied..."
flutter run --dart-define=ENVIRONMENT=prod
