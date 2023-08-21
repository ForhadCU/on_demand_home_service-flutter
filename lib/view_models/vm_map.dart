import 'dart:math';

class MapViewModel {
  double mCalculateDistanceFromLatLong({required double startLat, required double startLong,
  required double endLat, required double endLong})
  {

    const double earthRadius = 6371; // Earth's radius in kilometers

    double dLat = _degreesToRadians(endLat - startLat);
    double dLon = _degreesToRadians(endLong - startLong);

    double a = pow(sin(dLat / 2), 2) +
        cos(_degreesToRadians(startLat)) *
            cos(_degreesToRadians(endLat)) *
            pow(sin(dLon / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  
  }

    static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}