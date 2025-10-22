#!/bin/bash
# scripts/setup.sh

echo "🔧 Setting up Native Build Variants environment..."

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Generate env files
echo "🔨 Generating environment files..."
dart run build_runner build

echo "✅ Setup complete!"
echo ""
echo "Now you can build:"
echo "  ./scripts/build_dev.sh"
echo "  ./scripts/build_staging.sh"
echo "  ./scripts/build_prod.sh"
