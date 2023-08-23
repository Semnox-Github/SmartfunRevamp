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
```
  - SmartFunRevamp/android/app/build.gradle
  - SmartFunRevamp/android/app/google-services.json
  - SmartFunRevamp/android/app/src/debug/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/kotlin/com/example/semnox/MainActivity.kt
  - SmartFunRevamp/android/app/src/profile/AndroidManifest.xml
```
2. replace the string with the application id for this project

## configure initial URL
1. open `SmartFunRevamp/lib/core/api/parafait_api.dart`
2. change url in variable `const String kGetBaseUrl = 'https://parafaitdevcentral.parafait.com/api/';`

## firebase keys
follow instructions on official Firebase documentation https://firebase.google.com/docs/flutter/setup

## google authentication keys
Functionality not implemented yet

## google maps keys
follow instructions on official Goole Maps package documentation https://pub.dev/packages/google_maps_flutter

## native splash screen
This is the screen that is shown natively in the app before the flutter app is loaded
1. save image file in SmartFunRevamp/assets/splash_screen/splash_screen.png (you can change the name of the file, but you need to update the name in the step 3)
2. open file SmartFunRevamp/flutter_native_splash.yaml
3. update background_image path and color. You can ommit this step if you don't want to change the image path in step 1
4. run generation tool: `flutter pub pub run flutter_native_splash:create`

## native icon app
This is the icon of the app that is shown in the device berfore opening the app
1. save image file in SmartFunRevamp/assets/icon/icon.png (you change the name of the file, but you need to update the name in the step 3)
2. open file SmartFunRevamp/flutter_native_icons.yaml
3. update image path if you change it in the step 1
4. run generation tool: `flutter pub run flutter_launcher_icons`

## local CMS default configuration
For the moment the app is using only api calls to show data.
When the cache feature is implemented we will be using the file `SmartFunRevamp/assets/json/example_cms.json` to configure the CMS json data that loads for the first time the app is opened.

## app version and description.
The publicly visible app version is taken from `SmartFunRevamp/pubspec.yaml` file. The version is defined in the variable `version`. 
You can also change the app description in that file.
DO NOT change app name, because code compiling will fail.

