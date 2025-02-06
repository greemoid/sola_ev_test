# Sola EV Charging Stations App

This Flutter application displays a list of EV charging stations, allows users to view detailed information about each station, and mark stations as favorites. The favorite status is saved between app launches using `SharedPreferences`.

## Features
- **State Management:** Uses `BLoC` for predictable state handling.
- **Dependency Injection:** `GetIt` is used for managing dependencies.
- **Local Storage:** Favorites are stored using `SharedPreferences`.
- **Data Handling:** Data is loaded from a JSON file in the assets.
- **Smooth UI/UX:**
    - `Hero` animations enhance navigation transitions.
    - `cached_network_image` optimizes image loading.
    - My design is adaptive and optimized for both small devices like the iPhone SE and larger ones such as tablets, including newer foldable devices, which could be popular among the target audience for this app.
- **Navigation:** Implemented with `auto_route`, supporting web navigation.
- **Testing:** Includes unit and widget tests using `mocktail`.

## Getting Started

### Installation
Clone the repository and navigate to the project folder:
```sh
git clone https://github.com/greemoid/sola_ev_test.git
cd sola_ev_test
```
Install dependencies:
```sh
flutter pub get
```

### Running the App
This project uses code generation for navigation (`auto_route`). Before running, execute:
```sh
dart run build_runner build --delete-conflicting-outputs
```
Then, start the app:
```sh
flutter run
```

## Project Structure
I was trying to make the repository is well-structured. Feel free to explore the code organization in my [GitHub repository](https://github.com/greemoid/sola_ev_test).

## Demo
📽️ In the video, you'll be able to see the app's design adaptability, smooth animations, and the feature where favorites are retained even after restarting the app. 

Apologies for the lag in the video, but it's presented on a Linux app version because the Android emulator causes even more performance issues during video playback.

https://github.com/user-attachments/assets/fcfcaed6-0e10-4a8e-9b14-4ba14726f90d



