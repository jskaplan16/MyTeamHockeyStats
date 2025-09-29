# My Team Hockey Stats - Mobile App

This document explains how to convert your hockey stats website into a mobile app that can be uploaded to the App Store and Google Play Store.

## 🏒 Overview

Your hockey stats website has been converted into a hybrid mobile app using Apache Cordova. This allows you to:

- Deploy to both iOS App Store and Google Play Store
- Access native device features (camera, contacts, file system)
- Provide an app-like experience with native performance
- Maintain your existing ColdFusion backend

## 📱 Prerequisites

### For iOS Development:
- **macOS** (required for iOS development)
- **Xcode** (latest version from Mac App Store)
- **iOS Developer Account** ($99/year)
- **Node.js** (v14 or higher)
- **Cordova CLI**: `npm install -g cordova`

### For Android Development:
- **Windows, macOS, or Linux**
- **Android Studio** (latest version)
- **Android SDK** (API level 22 or higher)
- **Java Development Kit (JDK)** (v8 or higher)
- **Node.js** (v14 or higher)
- **Cordova CLI**: `npm install -g cordova`
- **Google Play Developer Account** ($25 one-time fee)

## 🚀 Quick Start

### 1. Install Dependencies

```bash
# Install Node.js (if not already installed)
# Download from: https://nodejs.org/

# Install Cordova globally
npm install -g cordova

# Install project dependencies
npm install
```

### 2. Build the Mobile App

```bash
# Make the build script executable (macOS/Linux)
chmod +x build-app.sh

# Run the build script
./build-app.sh
```

### 3. Test on Device/Simulator

```bash
# For iOS (requires macOS and Xcode)
cordova run ios

# For Android
cordova run android
```

## 📦 App Store Deployment

### iOS App Store

1. **Open Xcode Project**
   ```bash
   open cordova/platforms/ios/My\ Team\ Hockey\ Stats.xcworkspace
   ```

2. **Configure App Settings**
   - Set Bundle Identifier (e.g., `com.yourcompany.hockeystats`)
   - Set App Version and Build Number
   - Configure App Icons and Launch Screens
   - Set App Permissions

3. **Create App Store Connect Record**
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Create new app
   - Fill in app information, screenshots, description

4. **Archive and Upload**
   - In Xcode: Product → Archive
   - Upload to App Store Connect
   - Submit for review

### Google Play Store

1. **Generate Signed APK**
   ```bash
   # Create keystore (first time only)
   keytool -genkey -v -keystore hockeystats.keystore -alias hockeystats -keyalg RSA -keysize 2048 -validity 10000

   # Build release APK
   cordova build android --release
   ```

2. **Create Play Console Record**
   - Go to [Google Play Console](https://play.google.com/console)
   - Create new app
   - Upload APK and fill in store listing

3. **Submit for Review**
   - Complete store listing
   - Upload screenshots and graphics
   - Submit for review

## 🎨 Customization

### App Icons
Replace the placeholder icons in `cordova/res/icon/` with your custom app icons:

**iOS Icons Required:**
- `icon-60@2x.png` (120x120)
- `icon-60@3x.png` (180x180)
- `icon-76.png` (76x76)
- `icon-76@2x.png` (152x152)
- `icon-83.5@2x.png` (167x167)
- `icon-1024.png` (1024x1024)

**Android Icons Required:**
- `ldpi.png` (36x36)
- `mdpi.png` (48x48)
- `hdpi.png` (72x72)
- `xhdpi.png` (96x96)
- `xxhdpi.png` (144x144)
- `xxxhdpi.png` (192x192)

### Splash Screens
Replace splash screens in `cordova/res/screen/` with your custom designs.

### App Configuration
Edit `config.xml` to customize:
- App name and description
- Bundle identifier
- App permissions
- Platform-specific settings

## 🔧 Native Features

The mobile app includes these native features:

### Camera Access
```javascript
// Take a picture
window.takePicture();
```

### File System
```javascript
// Export data
window.exportData(data, 'hockey-stats.txt');
```

### Network Status
- Automatic offline/online detection
- Network status indicator
- Offline mode support

### Haptic Feedback
- Vibration on button press
- Touch feedback for better UX

### Device Information
- App version display
- Device information access
- Platform detection

## 📱 App Features

### iOS-Specific Features
- **Status Bar**: Custom styling and colors
- **Splash Screen**: Custom launch screen
- **App Icons**: High-resolution icons
- **Touch Gestures**: Native iOS gestures
- **Haptic Feedback**: Vibration and touch feedback

### Android-Specific Features
- **Material Design**: Android design guidelines
- **Back Button**: Hardware back button handling
- **Menu Button**: Hardware menu button support
- **Search Button**: Hardware search button support

## 🐛 Troubleshooting

### Common Issues

**Build Fails:**
```bash
# Clean and rebuild
cordova clean
cordova build
```

**Plugin Issues:**
```bash
# Remove and re-add plugins
cordova plugin remove [plugin-name]
cordova plugin add [plugin-name]
```

**iOS Build Issues:**
- Ensure Xcode is up to date
- Check iOS deployment target
- Verify certificates and provisioning profiles

**Android Build Issues:**
- Ensure Android SDK is properly installed
- Check Java version compatibility
- Verify Android build tools

### Debug Mode
```bash
# Enable debug logging
cordova run ios --debug
cordova run android --debug
```

## 📊 Performance Optimization

### WebView Optimization
- Enable hardware acceleration
- Optimize CSS animations
- Minimize JavaScript execution
- Use efficient image formats

### Memory Management
- Implement proper cleanup
- Monitor memory usage
- Optimize large datasets
- Use lazy loading

## 🔒 Security Considerations

### Data Protection
- Encrypt sensitive data
- Use secure storage
- Implement proper authentication
- Validate all inputs

### Network Security
- Use HTTPS for all communications
- Implement certificate pinning
- Validate SSL certificates
- Secure API endpoints

## 📈 Analytics and Monitoring

### App Analytics
- Track user engagement
- Monitor app performance
- Analyze user behavior
- Measure app success

### Crash Reporting
- Implement crash reporting
- Monitor app stability
- Track error rates
- Improve app quality

## 🆘 Support

### Documentation
- [Cordova Documentation](https://cordova.apache.org/docs/)
- [iOS Development Guide](https://developer.apple.com/ios/)
- [Android Development Guide](https://developer.android.com/)

### Community
- [Cordova Community](https://cordova.apache.org/community/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/cordova)
- [GitHub Issues](https://github.com/apache/cordova/issues)

## 📝 License

This mobile app is based on your existing hockey stats website. Ensure you have proper licensing for all components and comply with app store requirements.

## 🎯 Next Steps

1. **Test thoroughly** on multiple devices
2. **Create proper app icons** and splash screens
3. **Set up app store accounts** and developer profiles
4. **Prepare store listings** with screenshots and descriptions
5. **Submit for review** and monitor feedback
6. **Plan updates** and feature enhancements

---

**Good luck with your mobile app launch! 🏒📱**
