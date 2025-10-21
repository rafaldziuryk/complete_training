#!/bin/bash
# scripts/build_staging.sh

echo "🔨 Building STAGING APK with Android flavors..."
flutter build apk --flavor staging --release

echo "✅ Staging APK built successfully!"
echo "📱 App ID: com.example.flavorsdemo.staging"
echo "📱 App Name: Flavors Demo STAGING"
echo "🎨 Color: Orange"
echo "📁 Output: build/app/outputs/flutter-apk/app-staging-release.apk"
