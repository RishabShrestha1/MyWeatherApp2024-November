# WeatherApp 🌤️

A new Weather App that utilizes **The Weather API** to fetch and display real-time weather data.

---

## Features 🚀
- Displays current weather conditions using live data from The Weather API.
- Uses **Hydrated Bloc** for state management and location retention.
- Implements **Geolocation** to fetch weather data for the user's current location.
- Beautiful and responsive UI with a soothing color palette.

---

## Color Palette 🎨
The color scheme of the app is inspired by the palette from [Color Hunt](https://colorhunt.co/palette/78b3cec9e6f0fbf8eff96e2a):
- ![#78B3CE](https://via.placeholder.com/15/78B3CE/78B3CE.png) `#78B3CE`
- ![#C9E6F0](https://via.placeholder.com/15/C9E6F0/C9E6F0.png) `#C9E6F0`
- ![#FBF8EF](https://via.placeholder.com/15/FBF8EF/FBF8EF.png) `#FBF8EF`
- ![#F96E2A](https://via.placeholder.com/15/F96E2A/F96E2A.png) `#F96E2A`

---

## Dependencies 📦

The app leverages the following packages:

1. **[flutter_svg](https://pub.dev/packages/flutter_svg) (v2.0.16)**  
   - Enables rendering of SVG images as the `Image` widget does not support SVGs natively.

2. **[flutter_bloc](https://pub.dev/packages/flutter_bloc) (v8.1.6)**, **[bloc](https://pub.dev/packages/bloc) (v8.1.4)**, **[equatable](https://pub.dev/packages/equatable) (v2.0.7)**  
   - Used for state management, ensuring a scalable and maintainable app architecture.

3. **[hive_flutter](https://pub.dev/packages/hive_flutter) (v1.1.0)**, **[hydrated_bloc](https://pub.dev/packages/hydrated_bloc) (v9.1.5)**, **[path_provider](https://pub.dev/packages/path_provider) (v2.1.5)**  
   - Facilitates local storage for location retention. While Hive is my go-to solution, I experimented with **Hydrated Bloc** as a new method.

4. **[geolocator](https://pub.dev/packages/geolocator) (v13.0.2)**, **[permission_handler](https://pub.dev/packages/permission_handler) (v11.3.1)**  
   - Used to fetch the user's current location.

5. **[network_image](https://pub.dev/packages/network_image) (v0.1.1)**  
   - Allows rendering images directly from The Weather API.

6. **[http](https://pub.dev/packages/http) (v1.2.2)**  
   - For API calls and fetching weather data.

---

## How to Run the App 🛠️

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/weatherapp.git
   cd weatherapp
