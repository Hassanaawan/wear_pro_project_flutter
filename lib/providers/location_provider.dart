import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';

class LocationProvider with ChangeNotifier {
  double longitude;
  double latitude;
  bool permit=false;

  Future<void> getCurrentLocation() async {
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      this.longitude = position.longitude;
      this.latitude = position.latitude;
      this.permit=true;
      notifyListeners();
    }
    else{
      print('Permission not allowed');
    }
  }
//   Future<void> GetAddressFromLatLong()async {
//
// // From a query
//     final query = "1600 Amphiteatre Parkway, Mountain View";
//     var addresses = await Geocoder.local.findAddressesFromQuery(query);
//     var first = addresses.first;
//     print("${first.featureName} : ${first.coordinates}");
//
//     final coordinates = new Coordinates(1.10, 45.50);
//     addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     first = addresses.first;
//     print("${first.featureName} : ${first.addressLine}");
//     print('zzzzzzzzzzz');
//
//     // List<PlaceMark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//     // print(placemarks);
//     // Placemark place = placemarks[0];
//     // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//
//   }
}
