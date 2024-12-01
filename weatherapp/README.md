# weatherapp

A new Weather App which uses The Weather Api to get the data to show the weather.


## Project Details

The Color Pallete for the color of the app Used is as follows 
 https://colorhunt.co/palette/78b3cec9e6f0fbf8eff96e2a

The Packages used are 
  flutter_svg: ^2.0.16
    This was used to render svg images on the app as svg is not supported by Image widget
  flutter_bloc: ^8.1.6 &&  bloc: ^8.1.4 &&  equatable: ^2.0.7
    These are used to carryout the statemanagement in the app
  hive_flutter: ^1.1.0 &&  hydrated_bloc: ^9.1.5 &&   path_provider: ^2.1.5
    These Facilitated the location retention in the app i normally use hive but i have tried out hydrated bloc as a new method
  geolocator: ^13.0.2 && permission_handler: ^11.3.1
    For identifying the current Location
  network_image: ^0.1.1
    For Rendering Image from the Api Displaying the Weather
  http: ^1.2.2
    Its used to carry out api data fetching

