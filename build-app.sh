#!/bin/bash

# My Team Hockey Stats - Mobile App Build Script
# This script builds the mobile app for iOS and Android

echo "🏒 Building My Team Hockey Stats Mobile App..."

# Check if Cordova is installed
if ! command -v cordova &> /dev/null; then
    echo "❌ Cordova is not installed. Please install it first:"
    echo "npm install -g cordova"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install it first."
    exit 1
fi

# Create Cordova project if it doesn't exist
if [ ! -d "cordova" ]; then
    echo "📱 Creating Cordova project..."
    cordova create cordova com.myteamhockeystats.app "My Team Hockey Stats"
    cd cordova
    
    # Copy config.xml
    cp ../config.xml .
    
    # Add platforms
    echo "📱 Adding iOS platform..."
    cordova platform add ios
    
    echo "📱 Adding Android platform..."
    cordova platform add android
    
    # Add plugins
    echo "🔌 Adding plugins..."
    cordova plugin add cordova-plugin-statusbar
    cordova plugin add cordova-plugin-device
    cordova plugin add cordova-plugin-splashscreen
    cordova plugin add cordova-plugin-whitelist
    cordova plugin add cordova-plugin-network-information
    cordova plugin add cordova-plugin-file
    cordova plugin add cordova-plugin-file-transfer
    cordova plugin add cordova-plugin-camera
    cordova plugin add cordova-plugin-contacts
    cordova plugin add cordova-plugin-inappbrowser
    cordova plugin add cordova-plugin-dialogs
    cordova plugin add cordova-plugin-vibration
    cordova plugin add cordova-plugin-geolocation
    cordova plugin add cordova-plugin-app-version
    cordova plugin add cordova-plugin-email-composer
    cordova plugin add cordova-plugin-social-sharing
    
    cd ..
fi

# Copy web assets to Cordova project
echo "📁 Copying web assets..."
cp -r assets cordova/www/
cp -r actions cordova/www/
cp -r customtags cordova/www/
cp -r displays cordova/www/
cp -r forms cordova/www/
cp -r includes cordova/www/
cp -r pages cordova/www/
cp *.cfm cordova/www/
cp *.xml cordova/www/
cp *.txt cordova/www/
cp *.md cordova/www/

# Copy mobile app wrapper
cp mobile-app.html cordova/www/index.html

# Create app icons and splash screens
echo "🎨 Creating app icons and splash screens..."
mkdir -p cordova/res/icon/ios
mkdir -p cordova/res/icon/android
mkdir -p cordova/res/screen/ios
mkdir -p cordova/res/screen/android

# Copy existing favicon as app icon (you should create proper icons)
cp assets/images/favicon.ico cordova/res/icon/ios/icon-60@2x.png
cp assets/images/favicon.ico cordova/res/icon/ios/icon-60@3x.png
cp assets/images/favicon.ico cordova/res/icon/ios/icon-76.png
cp assets/images/favicon.ico cordova/res/icon/ios/icon-76@2x.png
cp assets/images/favicon.ico cordova/res/icon/ios/icon-83.5@2x.png
cp assets/images/favicon.ico cordova/res/icon/ios/icon-1024.png

# Copy to Android icons
cp assets/images/favicon.ico cordova/res/icon/android/ldpi.png
cp assets/images/favicon.ico cordova/res/icon/android/mdpi.png
cp assets/images/favicon.ico cordova/res/icon/android/hdpi.png
cp assets/images/favicon.ico cordova/res/icon/android/xhdpi.png
cp assets/images/favicon.ico cordova/res/icon/android/xxhdpi.png
cp assets/images/favicon.ico cordova/res/icon/android/xxxhdpi.png

# Create splash screens (you should create proper splash screens)
cp assets/images/favicon.ico cordova/res/screen/ios/Default@2x~iphone.png
cp assets/images/favicon.ico cordova/res/screen/ios/Default@3x~iphone.png
cp assets/images/favicon.ico cordova/res/screen/ios/Default@2x~ipad.png
cp assets/images/favicon.ico cordova/res/screen/ios/Default@2x~universal.png

# Copy to Android splash screens
cp assets/images/favicon.ico cordova/res/screen/android/land-ldpi.png
cp assets/images/favicon.ico cordova/res/screen/android/land-mdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/land-hdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/land-xhdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/land-xxhdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/land-xxxhdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/port-ldpi.png
cp assets/images/favicon.ico cordova/res/screen/android/port-mdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/port-hdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/port-xhdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/port-xxhdpi.png
cp assets/images/favicon.ico cordova/res/screen/android/port-xxxhdpi.png

# Build the app
cd cordova

echo "🔨 Building iOS app..."
cordova build ios

echo "🔨 Building Android app..."
cordova build android

echo "✅ Build complete!"
echo ""
echo "📱 iOS app location: platforms/ios/build/emulator/"
echo "📱 Android app location: platforms/android/app/build/outputs/apk/debug/"
echo ""
echo "🚀 To run on device:"
echo "   iOS: cordova run ios --device"
echo "   Android: cordova run android --device"
echo ""
echo "📦 To create release builds:"
echo "   iOS: cordova build ios --release"
echo "   Android: cordova build android --release"
