# How to configure a new app for a customer

## Initial setup
1. Install Flutter following official documentation: https://docs.flutter.dev/get-started/install
2. Be sure you are able to run the demo counter flutter app created by: `flutter create`
3. Make sure git user has access to auxiliar repositories:
  - https://github.com/nitinpai-semnox/Parafait-BarCodeReader
  - https://github.com/nitinpai-semnox/Parafait-NFC 
4. Be sure to be able to run semnox app in development mode with: `flutter run`

## Change application id
1. Open every file with the string: `com.example.semnox`, the list of files is
```
  - SmartFunRevamp/android/app/build.gradle
  - SmartFunRevamp/android/app/google-services.json
  - SmartFunRevamp/android/app/src/debug/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/kotlin/com/example/semnox/MainActivity.kt
  - SmartFunRevamp/android/app/src/profile/AndroidManifest.xml
```
2. Replace the string with the application id selected for this project

## Configure initial URL
1. Open `SmartFunRevamp/lib/core/api/parafait_api.dart`
2. Change url in variable `const String kGetBaseUrl = 'https://parafaitdevcentral.parafait.com/api/';`

## Firebase keys
Follow instructions on official Firebase documentation https://firebase.google.com/docs/flutter/setup

## Google authentication keys
Functionality not implemented yet

## Google maps keys
Follow instructions on official Goole Maps package documentation https://pub.dev/packages/google_maps_flutter

## Native splash screen
This is the screen that is shown natively in the app before the flutter app is loaded
1. Save chosen image file in `SmartFunRevamp/assets/splash_screen/splash_screen.png` (you can change the name of the file, but you need to update the name in the next step).
2. Open file `SmartFunRevamp/flutter_native_splash.yaml` and update `background_image` and `color`. You can ommit this step if you used the default name for the image file in the step 1
4. Run generation tool: `flutter pub pub run flutter_native_splash:create`

## Native icon app
This is the icon of the app that is shown in the device berfore opening the app
1. Save image file in `SmartFunRevamp/assets/icon/icon.png` (you change the name of the file, but you need to update the name in the step 3). PNG file with transparent background is recommended
2. Open file `SmartFunRevamp/flutter_native_icons.yaml` and update image path if you change it in the step 1
3. Run generation tool: `flutter pub run flutter_launcher_icons`

## Local json default configuration
For the moment the app is using only api calls to show data.

When the cache feature is implemented we will be using JSON files inside `SmartFunRevamp/assets/json/` to configure the CMS json data such as: 
- available languages
- default translated strings
- parafait defaults
- CMS json data for home, colors, fonts, etc.
- any other aata that need to load faster the first time the app is opened

## App version and description.
The publicly visible app version is taken from `SmartFunRevamp/pubspec.yaml` file. The version is defined in the variable `version`. 

You can also change the app description in that file.

*DO NOT change app name*, because code compiling will fail.