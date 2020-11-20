# SafeShopper

A way to cater the needs of people by connecting them with local businesses.

---

## Android App

Go to **build\app\outputs\apk\release** folder, then transfer one of these apks to your android device and install it:  
- *app-arm64-v8a-release.apk*  (this will work for most android devices)  
- *app-x86_64-release.apk*     (use this if above doesn't work)  
- *app-armeabi-v7a-release.apk* (use this if above two doesn't work)  
  
### Optional
If you want to compile the app yourself, follow these steps:
1. Setup [Flutter](https://flutter.dev/docs/get-started/install).
2. Setup [editor](https://flutter.dev/docs/get-started/editor).
3. Open the project folder. Then follow these [steps to run](https://flutter.dev/docs/get-started/test-drive)
---

## IPhone App
For iPhone app, you need to have MacBook.  
Steps to compile app for iPhone platform:
1. Setup [Xcode](https://developer.apple.com/xcode/ide/) in MacBook.
2. Setup [Flutter](https://flutter.dev/docs/get-started/install/macos).
3. - Using Xcode, open the project's **ios/Runner.xcworkspace** file. Right click Runner from the left-hand side project navigation within Xcode and select "Add files".
   - Select the **GoogleService-Info.plist** file from **assets/** folder, and ensure the "Copy items if needed" checkbox is enabled.
4. Then, follow these [steps](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices).

---

## Web App  

Open either of following links in any browser:  
- <https://safeshopper-eedd3.web.app/>
- <https://safeshopper-eedd3.firebaseapp.com/>
>### Warning!
> These websites are not optimized for large screens.  
> So, open these only in smartphones.