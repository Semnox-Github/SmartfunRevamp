# how to configure a new app for a customer

## initial setup
1. install flutter, follow official documentatio
2. be sure you are able to run the demo counter flutter app created by: flutter create
3. make user has access to auxiliar repositories:
  - https://github.com/nitinpai-semnox/Parafait-BarCodeReader
  - https://github.com/nitinpai-semnox/Parafait-NFC 
4. run semnox app in development mode

## change application id
1. open every file with the string: `com.example.semnox`, the list of files is
  - SmartFunRevamp/android/app/build.gradle
  - SmartFunRevamp/android/app/google-services.json
  - SmartFunRevamp/android/app/src/debug/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/kotlin/com/example/semnox/MainActivity.kt
  - SmartFunRevamp/android/app/src/profile/AndroidManifest.xml
2. replace the string with the application id for this project

## configure initial URL
1. open `SmartFunRevamp/lib/core/api/parafait_api.dart`
2. change url in variable `const String kGetBaseUrl = 'https://parafaitdevcentral.parafait.com/api/';`

## firebase keys
follow instructions on official flutter documentation https://firebase.google.com/docs/flutter/setup

## google maps keys

## native splash screen
is the screen that is shown natively in the app before the flutter app is loaded
1. open file SmartFunRevamp/flutter_native_splash.yaml
2. update background_image path and color
3. run generation tool: `flutter pub pub run flutter_native_splash:create`

## native icon app
is the icon of the app that is shown in the device
1. open file SmartFunRevamp/flutter_native_icons.yaml
2. update image path
3. run generation tool: `flutter pub run flutter_launcher_icons`


