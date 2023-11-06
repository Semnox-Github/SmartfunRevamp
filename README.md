How to configure a new app for a customer
=========================================

# 1. Initial setup
1. Install Flutter following official documentation: https://docs.flutter.dev/get-started/install
2. Be sure you are able to run the demo counter flutter app created by: `flutter create`
3. Make sure git user has access to auxiliar repositories:
  - https://github.com/nitinpai-semnox/Parafait-BarCodeReader
  - https://github.com/nitinpai-semnox/Parafait-NFC 
4. Be sure to be able to run semnox app in development mode with: `flutter run`

# 2. Change application id
- Open every file with the string: `com.example.semnox`, the list of files is
```
  - SmartFunRevamp/android/app/build.gradle
  - SmartFunRevamp/android/app/google-services.json
  - SmartFunRevamp/android/app/src/debug/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/AndroidManifest.xml
  - SmartFunRevamp/android/app/src/main/kotlin/com/example/semnox/MainActivity.kt
  - SmartFunRevamp/android/app/src/profile/AndroidManifest.xml
```
- Replace the string with the application id selected for this project

# 3. Configure .env file
1. Copy the file .env.example to .env
2. These are the values of this files, explained:
  - GET_BASE_URL: the default url for the API that will be called first time the app runs
  - SECRET_KEY: the secret key used for authentication against the api
  - BUILD_NUMBER: app version number, used to check if there is a new version available against api
  - BUILD_SECURITY_CODE: security code for the build to send to the api with the version number
  - USE_LOCAL_CMS_JSON: if true, the app will use the local json file for CMS configuration. If false, the app will fetch the configuration from the API. Only for using during development, for production this should be false
  - APP_TITLE: this is the title of the app that is shown when switching between apps in the device

# 4. Firebase keys
Follow instructions on official Firebase documentation https://firebase.google.com/docs/flutter/setup

# 5. Google authentication keys
Functionality not implemented yet

# 6. Google maps keys
Follow instructions on official Goole Maps package documentation https://pub.dev/packages/google_maps_flutter

# 7. Native splash screen
This is the screen that is shown natively in the app before the flutter app is loaded
1. Save chosen image file in `SmartFunRevamp/assets/splash_screen/splash_screen.png` (you can change the name of the file, but you need to update the name in the next step).
2. Open file `SmartFunRevamp/flutter_native_splash.yaml` and update `background_image` and `color`. You can ommit `background_image` if you used the default name for the image file in the step 1
3. Run generation tool: `flutter pub pub run flutter_native_splash:create`

# 8. Native icon app
This is the icon of the app that is shown in the device berfore opening the app
1. Save image file in `SmartFunRevamp/assets/icon/icon.png` (you can change the name of the file, but you need to update the name in the step 3). PNG file with transparent background is recommended.
2. Open file `SmartFunRevamp/flutter_native_icons.yaml` and update image path if you change it in the step 1.
3. Run generation tool: `flutter pub run flutter_launcher_icons`

# 9. JSON configuration
There are serveral parts of the app that can be configured by json files. For every configuration there is a file that is shipped inside the app and that is read by default the first time the app is opened. After that, the app will fetch a new configuration from the API and will store it in the device. Next time the app is opened, the json from the API will be used instead of the one shipped with the app.

**Below is a list of the json files that can be configured:**

## 9.1. Available languages
The app can be configured to support multiple languages. The list of available languages is defined in `SmartFunRevamp/assets/json/language_container.json` file. The format of the file is:
```
{
  "LanguageContainerDTOList": [
    {
      "LanguageId": 2,
      "LanguageName": "English",
      "LanguageCode": "en-US",
      "CultureCode": "en-US"
    },
    {
      "LanguageId": 3,
      "LanguageName": "Spanish",
      "LanguageCode": "es-ES",
      "CultureCode": "es-ES"
    },
    {
      "LanguageId": 4,
      "LanguageName": "French",
      "LanguageCode": "fr-FR",
      "CultureCode": "fr-FR"
    }
  ]
}
```

## 9.2. Default translated strings
The app can be configured to support multiple languages. The first time the app is opened the translations strings are shown from the file `SmartFunRevamp/assets/localization/strings.json`. The format of the file is:
```
{
  "string": "Translated string",
  "hello": "hello translated",
  "world": "world translated"
}
```

## 9.3. Parafait defaults
The file should be located at `SmartFunRevamp/assets/json/parafait_defaults_local.json`. The format of the file is:
```
{
  "ParafaitDefaultContainerDTOList": [
    {
      "DefaultValueName": "CARD_FACE_VALUE",
      "DefaultValue": "0"
    },
    {
      "DefaultValueName": "TOKEN_PRICE",
      "DefaultValue": "10"
    },
    {
      "DefaultValueName": "POS_CARD_READER_BAUDRATE",
      "DefaultValue": "9600"
    },
    # more items here...
  ]
}
```

## 9.4. CMS configuration
It contains data to configure the app such as: home containers, menu itesm, colors, etc. The file is `SmartFunRevamp/assets/json/example_cms.json`
The next items are configured in the same file.

### 9.4.1. Home containers
The containers in the home page can be of different types. The available types are:

- CARDS: shows the widget with the list of the cards of the user
- LINKS: shows a list of links to other pages inside the app
- CAROUSEL: shows a carousel of images with links to external pages loaded inside a webview in the app

The configuration for this containers is made in 2 different places in the json file:

1. `HomePageOrder` is a list of the containers that will be shown in the home page. The `widget` value points to a container defined in the next section.

This is the format of the `HomePageOrder` list:

```
"HomePageOrder": [
  {
    "title": "My Tickets",
    "position": 4,
    "widget": "CARDS",
    "is_visible": true
  },
  {
    "title": "Quick Links",
    "position": 10,
    "widget": "LINKS",
    "is_visible": true,
    "display_section": "QUICKLINKS"
  },
  {
    "title": "Promotions",
    "position": 2,
    "widget": "CAROUSEL",
    "is_visible": true,
    "display_section": "PROMOS_1"
  },
  {
    "title": "More Actions",
    "position": 3,
    "widget": "LINKS",
    "is_visible": true,
    "display_section": "MORE_ACTIONS"
  }
  # more items here ...
],
```

2. `CMSModulePageDTOList` is the actual data pointed from the previous section
```
"CMSModulePageDTOList": [
{
  "Source": "CARDS",
  "ContentName": "",
  "DisplaySection": "WIDGET",
  "DisplayOrder": 5,
  "Active": true,
  "Site_id": 1010,
  "CMSContentTemplateDTO": null,
  "SectionName": "",
  "MasterEntityId": -1,
  "ParentContentId": -1,
  "Height": 25,
  "Width": 90,
  "ContentURL": "",
  "IsChanged": true
},
{
  "Source": "PROMOTIONS",
  "ContentName": "",
  "DisplaySection": "CAROUSEL",
  "DisplayOrder": 3,
  "Active": true,
  "Site_id": 1010,
  "CMSContentTemplateDTO": null,
  "SectionName": "",
  "MasterEntityId": -1,
  "ParentContentId": -1,
  "Height": 28,
  "Width": 90,
  "ContentURL": "",
  "IsChanged": true
},
{
  "Source": "PromoImage1",
  "ContentName": "",
  "DisplaySection": "PROMOS_1",
  "DisplayOrder": 1,
  "Active": true,
  "Site_id": 1010,
  "CMSContentTemplateDTO": null,
  "SectionName": "",
  "MasterEntityId": -1,
  "ParentContentId": 330,
  "Height": 28,
  "Width": 90,
  "ContentURL": "https://parafaitapihqdemo.parafait.com/images/promoimages/promoOne.png",
  "IsChanged": true
},

```

### 9.4.2. Menu items
Menu items are inside the key `CMSModuleMenuDTOList`

The available items keys for configuration are:

- SMARTFUN_MENU_HEADER
- SMARTFUN_MENU_FOOTER
- SMARTFUN_MENU_CARD_DETAILS
- SMARTFUN_MENU_MORE

the configuration for this items is the following:

```
"CMSModuleMenuDTOList": [
  {
    "CMSMenusDTOList": [
      {
        "Name": "SMARTFUN_MENU_FOOTER",
        "Type": "FOOTER",
        "Active": true,
        "CMSMenuItemsDTOList": [
          {
            "ItemName": "HOME",
            "ItemUrl": "https://parafaitapihqdemo.parafait.com/images/ftHomeIcon.png",
            "Target": "sf://home",
            "Active": true,
            "DisplayOrder": 1,
            "DisplayName": "Home",
          },
          # More items here ...
        ],
      }
    ]
  },
  {
    "CMSMenusDTOList": [
      {
        "Name": "SMARTFUN_MENU_CARD_DETAILS",
        "Type": "CARD_DETAILS",
        "Active": true
        "CMSMenuItemsDTOList": [
          {
            "ItemName": "BONUS",
            "ItemUrl": "https://parafaitapihqdemo.parafait.com/images/ftHomeIcon.png",
            "Active": true,
            "DisplayOrder": 1,
            "DisplayName": "Bonus",
            "CreditType": 5
          },
          # More items here ...
        ],
      }
    ]
  },
  # More items here ...
],
```

**Particular cases an exceptions**

- SMARTFUN_MENU_CARD_DETAILS has an extra key `CreditType` that is used to filter the cards by credit type. In this case the `Target` key is not used. The values are:
  - 0: credits
  - 1: loyalty
  - 2: tickets
  - 5: bonus 
  - 6: time 
- PLAY: in this case the `Target` key is not the internal route inside the app, but the url to open inside the webview.
- When the `Target` key is eaqual to `sf://webview` an extra key called `TargetUrl` is being used to determine which url should be opened inside the webview.
- Then the `Target` key starts with `http://` or `https://` the url is opened in the device browser.

### 9.4.3. App Colors, fonts and images

This is the structure:

```
  "CMSModuleColorsHome": {
    "upper_half": "#FFCFF8FF",
    "middle": "#FFFFFFFF",
    "bottom_half": "#FF1F1E2C",
    "profile_picture_gradient": ["#FFFFF2AD", "#FFFFA322"]
  },
  "CardsColor": {
    "color_card_text": "#ffffff",
    "regular": "#FF613F75",
    "expired": "#FFE5C3D1",
    "virtual": "#FFEF798A"
  },
  "images": {
    "splash_screen_image_path": "https://placehold.co/1200x400.png",
    "language_pick_image_path": "https://placehold.co/1200x400.png",
    "logo_image_path": "https://placehold.co/1200x400.png",
    "coupon_congrats_image_path": "https://placehold.co/1200x400.png",
    "blocked_image_path": "https://placehold.co/1200x400.png",
    "expired_image_path": "https://placehold.co/1200x400.png",
    "QR_image_path": "https://placehold.co/1200x400.png",
    "coin_image_path": "https://placehold.co/1200x400.png",
    "barcode_image_path": "https://placehold.co/1200x400.png",
    "no_promo_image_path": "https://placehold.co/1200x400.png",
    "check_ok_image_path": "https://placehold.co/1200x400.png",
    "bronze_image_path": "https://placehold.co/1200x400.png",
    "silver_image_path": "https://placehold.co/1200x400.png",
    "gold_image_path": "https://placehold.co/1200x400.png",
    "diamond_image_path": "https://placehold.co/1200x400.png",
    "platinum_image_path": "https://placehold.co/1200x400.png",
    "payment_failed_image_path": "https://placehold.co/1200x400.png",
    "recharge_successful_image_path": "https://placehold.co/1200x400.png",
    "reset_password_success_image_path": "https://placehold.co/1200x400.png",
    "select_location_image_path": "https://placehold.co/1200x400.png",
    "transfer_success_image_path": "https://placehold.co/1200x400.png"
  },
```

# 10. App version and description.
The publicly visible app version is taken from `SmartFunRevamp/pubspec.yaml` file. The version is defined in the variable `version`. This should match with the version defined in the `.env` file

You can also change the app description in that file.

*DO NOT change app name*, because code compiling will fail.

# 11. Other App colors

All colors that are not defined in the json files are defined in the file `SmartFunRevamp/lib/colors/colors.dart`.
The colors are used in serveral places of the app such as: buttons, text, backgrounds, gradients, etc. Changing colors in this file will affect the app globally, but the colors are not semantcally defined, so you will need to trial and test to understand which colors you are changing.

# 12. Disable debug banner

To disable the debug banner in the app, open the file `SmartFunRevamp/lib/main.dart` and change the value of the variable `debugShowCheckedModeBanner` to `false`

# 13. Missing translations strings

Every string that has not a corresponding translation in the configuration file `SmartFunRevamp/assets/localization/strings.json` or its API version, will be shown in the app as the key of the string. For example, if the app is configured to support english and spanish, and the string `hello` is not defined in the configuration file, the app will show `hello` in english and `hello` in spanish.

In order to help with recopilating all non-translated strings, every time that a string is not found it's saved in the local storage. You can go to `SmartFunRevamp/lib/features/splash/provider/splash_screen_notifier.dart` and remove the comment in line 84 so the code `Logger().d(labels);` shows the list of every untranslated string.

# 14. Deploy and upgrade the app

The tool we recommend is [Microsfot App Center](https://appcenter.ms), a cloud-based service that helps developers build, test, distribute, and monitor their apps. It offers a wide range of features, including:

- Continuous integration and continuous delivery (CI/CD): App Center can automatically build and test your app whenever you push changes to your Git repository. This helps you to release your app more frequently and with confidence.
- App distribution: App Center makes it easy to distribute your app to testers and to the app stores. You can create distribution groups and assign different builds to different groups. You can also promote builds from one group to another, such as from beta testers to the app store.
- App monitoring: App Center provides crash analytics and other insights into how your app is performing in the real world. This information can help you to identify and fix problems quickly.

*Automatic deployment from Git branches:*

App Center makes it super easy to connect Git branches with app versions for automatic deployment. To do this, you simply need to add a post-merge hook to your Git repository. This hook will automatically build and deploy your app to the selected distribution group whenever you push changes to a specific branch.

*Alternatives to Microsoft App Center:*

- Firebase App Distribution: Firebase App Distribution is a similar service to App Center that offers app distribution and monitoring features. However, it does not offer CI/CD features.
- AWS Amplify: AWS Amplify is a mobile development platform that offers a variety of features, including CI/CD, app distribution, and app monitoring. However, it is more complex to use than App Center.
- Bitrise: Bitrise is another cloud-based CI/CD platform that can be used to distribute apps. However, it is not as user-friendly as App Center.
