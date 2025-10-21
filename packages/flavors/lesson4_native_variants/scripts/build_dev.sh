#!/bin/bash
# scripts/build_dev.sh

echo "🔨 Building DEVELOPMENT APK with Android flavors..."
flutter build apk --flavor dev --release

echo "✅ Development APK built successfully!"
echo "📱 App ID: com.example.flavorsdemo.dev"
echo "📱 App Name: Flavors Demo DEV"
echo "🎨 Color: Green"
echo "📁 Output: build/app/outputs/flutter-apk/app-dev-release.apk"
