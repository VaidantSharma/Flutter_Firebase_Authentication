This is a flutter project that aims to show how to link a Flutter project with Firebase and implement the Firebase Authentication method to it
The method used here to integrate the Firebase to this Project is using Flutterfire CLI
There are also some possible issues which you might encounter while Running the Application there solutions are listed below.
If you face any other challenge you can reach me out 
-Here is a step to step guide on how to Do it 
    1.Open the Terminal
    2.Type the Prompt ' firebase login' and Login in to it( Skip the step if already done)
    3.Type the Prompt 'dart pub global activate flutterfire_cli'
    4.Now open a tab and search for firebase and login to it and craete a new project over there select the platform as flutter
    5.Type the Prompt 'flutter configure' it will load all the available  projects
    6.Select the Project and then select the platform for which you want to implement your project
    7.Enter the applicationId which of this form "com.example.yourAppName". (Don't use Quotes, applicationId can also be found in android/app/build.gradle )
    8.Type the Prompt 'flutter pub add firebase_core' and import it to your project
    9.Other packages which you need to import are 'firebase_auth'. (To add any firebase package to your project use terminal and type 'flutter pub add firebase_packageName')
    10.Now again go to the Firebase console and open your project, in the Left Side under Product Categories go to build and select authentication.
    11.Now setup a new provider using Email and Password authentication method.
    12. Now write the flutter code to your Application

Possible Error
    1. Current AndroidSDK version incompatible
        To resolve this issue go to android/app/build.gradle directory and inside defaultConfig{} set minSdk = 23.
