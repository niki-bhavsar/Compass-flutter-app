**<h1 align=center>Compass Software</h1>**

<p align="center">
<a href="https://apps.apple.com/us/app/compass-software/id6733239938"><img src="https://img.shields.io/badge/App_Store-0D96F6?style=for-the-badge&logo=app-store&logoColor=white" alt="App Store"></a>
<a href="https://testflight.apple.com/join/nsneE1Ej"><img src="https://img.shields.io/badge/TestFlight-0D96F6.svg?style=for-the-badge&logo=textpattern&logoColor=white" alt="TestFlight"></a>
<a href="https://github.com/Kernel-Equity/compass-iphone-app"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="Github Repo"></a>
<a href="https://console.firebase.google.com/project/compass-EB743B /overview"><img src="https://img.shields.io/badge/firebase-EB743B?style=for-the-badge&logo=firebase&logoColor=white" alt="Firebase"></a>
</p>

## Getting Started

##### 1. Download packages
  ```sh
  flutter pub get
  ```

  ```sh
  flutter gen-l10n
  ```

##### 2. Run Android App
  ```sh
  flutter run --flavor prod
  ```

##### 3. Run iOS App
  ```sh
  flutter run --flavor Compass[PROD]
  ```

## Code Guidelines

##### 1. Performs static code analysis
  ```sh
  dart analyze --fatal-infos
  ```

##### 2. Check Dart formatting guidelines
  ```sh
  dart format --line-length 100 lib
  ```


## Tech stack & 3rd Party libraries
- iOS
    - Minimum SDK level 13
- Objective-C
- DynamSoft v9.6.10 for Barcode Scanning (GS1-128 Barcode format)
- Firebase Analytics, Crashlytics & Performance Monitoring
