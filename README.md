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
📽️ *Presentation video coming soon...*


