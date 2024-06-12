import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  // 현재 위치를 가져오는 함수
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스가 활성화되어 있는지 확인합니다.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('위치 서비스가 비활성화되어 있습니다.');
    }

    // 위치 권한 상태를 확인합니다.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('위치 권한이 영구적으로 거부되어 권한을 요청할 수 없습니다.');
    }

    // 현재 위치를 가져옵니다.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // 좌표를 주소로 변환하는 함수
  static Future<List<String?>> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      return [place.administrativeArea, place.locality, place.thoroughfare];
    } catch (e) {
      throw Exception("주소를 가져오지 못했습니다: $e");
    }
  }

  // 현재 주소를 가져오는 함수
  static Future<List<String?>> getCurrentAddress() async {
    Position position = await getCurrentPosition();
    return ["경기도", "안성시", "대덕면"];
    //return await getAddressFromLatLng(position);
  }
}
