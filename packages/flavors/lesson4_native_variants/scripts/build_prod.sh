#!/bin/bash
# scripts/build_prod.sh

echo "🔨 Building PRODUCTION APK with Android flavors..."
flutter build apk --flavor prod --release

echo "✅ Production APK built successfully!"
echo "📱 App ID: com.example.flavorsdemo"
echo "📱 App Name: Flavors Demo"
echo "🎨 Color: Blue"
echo "📁 Output: build/app/outputs/flutter-apk/app-prod-release.apk"
