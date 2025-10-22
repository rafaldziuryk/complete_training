#!/bin/bash
# scripts/setup.sh

echo "🔧 Setting up Envied environment..."

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Generate env files
echo "🔨 Generating environment files..."
dart run build_runner build

echo "✅ Setup complete!"
echo ""
echo "Now you can run:"
echo "  ./scripts/run_dev.sh"
echo "  ./scripts/run_staging.sh"
echo "  ./scripts/run_prod.sh"
