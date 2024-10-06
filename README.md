[![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)](https://thebsd.github.io/StandWithPalestine)


# 📱 Flutter Firebase Phone Auth & Google Maps App

## Overview
This app allows users to authenticate using their Egyptian phone number with Firebase Phone Authentication and provides location-based functionality using Google Maps. Users can search for places, view their current location, and display routes between locations.

## Features
- **Firebase Phone Authentication**: Users sign in using an Egyptian phone number, receive an SMS code for authentication.
- **Google Maps Integration**: View current location, place markers, and display routes between two locations using Google Places API and Routes API.
- **Search Bar**: Users can search for places using the Places API, with autocomplete suggestions.
- **Marker Interaction**: Displays a marker for the searched place and another for the user’s current location, with `InfoWindow` showing details.
- **Distance & Time Calculation**: Displays distance and estimated time for travel under the search bar.
- **Navigation Drawer**: Contains the user’s phone number, a profile image, and options like 'My Profile', 'Places History', 'Settings', and 'Help'.
- **Social Media Links**: Quick access to GitHub, Facebook, YouTube, and LinkedIn icons.
- **Logout Option**: Securely logs out the user.

## Demo
### Video
<div align="left">
      <a href="https://youtu.be/FNxWpmofhk4" target="_blank">
         <img src="https://github.com/user-attachments/assets/67662a09-1d02-48ec-9f2c-ce16d8597ad1" style="width:300px;">
      </a>
</div>

### GIF


https://github.com/user-attachments/assets/0dec27ef-5874-4e43-a8a9-ab3f2e5698a0



## Screenshots

1. Login Screen

<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/bf8f7998-0bd6-4a56-81a4-f0b378bc4380" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/df29fd1f-1e82-48aa-aea5-5504ac23e19f" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/3094df32-064d-406b-9da3-1d8a7f17f0e6" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/2149fbef-d72e-4d6c-85e7-0f0f752e35e0" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

---

2. Google Maps View

<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/67662a09-1d02-48ec-9f2c-ce16d8597ad1" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/baa6178c-799c-48fb-9004-be207c7ac88a" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/a68f8cb7-0f1e-469d-9437-1fef8a58476f" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/6f58744f-4470-465e-9a54-b9837546e394" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/8cfa9aff-53a5-4c1d-9eb3-dbe7454c5e03" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/b6fcbc5b-71af-4f2e-b02f-c71888a4132e" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/02a7de33-c51e-47e6-a542-b5e156693c43" alt="drawing" style="width:250px;"/>
        <img src="https://github.com/user-attachments/assets/06d8cca5-6115-455d-841c-1f5e9c6292f9" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

---

3. Drawer

<HTML>
    <body>
        <img src="https://github.com/user-attachments/assets/408445d4-434a-4af8-b259-3f4e6e55f3cc" alt="drawing" style="width:250px;"/>
    </body>
</HTML>

## Dependencies
Here’s a breakdown of the key dependencies used in the app:

- **Dio**: For making HTTP requests to APIs, including Google Maps API.
- **Firebase Auth**: Provides the Firebase Phone Authentication feature.
- **Firebase Core**: Core package for initializing Firebase services.
- **Flutter Bloc**: State management using Cubit and Bloc pattern.
- **Flutter Polyline Points**: For drawing polylines (routes) on Google Maps.
- **Flutter ScreenUtil**: To manage responsive layouts across different screen sizes.
- **Font Awesome Flutter**: Icon set for adding social media icons and other UI elements.
- **Geolocator**: For getting the user’s current location.
- **Google Maps Flutter**: Embeds Google Maps into the app.
- **Material Floating Search Bar**: Provides the floating search bar with suggestions.
- **Pin Code Fields**: For displaying and entering the OTP during phone authentication.
- **Pretty Dio Logger**: Logs Dio HTTP requests and responses in a readable format.
- **URL Launcher**: Opens URLs in external apps, used for social media links.
- **UUID**: Generates unique IDs for various use cases like identifying markers or places.

## Setup & Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/MoazSayed7/Flutter-Google-Maps.git
   cd Flutter-Google-Maps
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**:
   - Create a Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/).
   - Enable Firebase Phone Authentication in your Firebase project.
   - Set up Firebase for your project by following the [Using Firebase CLI](https://firebase.google.com/docs/flutter/setup).
   
4. **Google Maps API Setup**:
   - Replace the default API keys with your own in the following files:
     - Android: `android/app/src/main/AndroidManifest.xml`  
       ```xml
       <meta-data
           android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_API_KEY"/>
       ```
     - iOS: `ios/Runner/AppDelegate.swift`  
       ```swift
       GMSServices.provideAPIKey("YOUR_API_KEY")
       ```
     - API Calls: `lib/constants/strings.dart`  
       ```dart
       const googleAPIKey = 'YOUR_API_KEY';
       ```

5. **Run the App**:
   ```bash
   flutter run
   ```


## How It Works
- **Login**: The user inputs their Egyptian phone number, and Firebase sends an OTP for verification.
- **Map Screen**: After logging in, the user is presented with a Google Map. The user can search for locations, view distance and time, and interact with the map.
- **Routes & InfoWindows**: The app shows routes, markers, and additional info when the user selects a place or their current location.


## Contributing
Feel free to fork the repository and make contributions. Please open an issue if you encounter any problems or have suggestions for improvements.
