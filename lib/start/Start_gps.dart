import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  // 현재 위치를 가져오는 함수
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    print('위치 서비스 활성화 확인');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('위치 서비스가 비활성화되어 있습니다.');
    }

    print('위치 권한 상태를 확인');
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('위치 권한이 거부되었습니다.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('위치 권한이 영구적으로 거부되어 권한을 요청할 수 없습니다.');
    }

    print('현재 좌표 확인');
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

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
    //return await getAddressFromLatLng(position);
    return ["경기도", "안성시", "대덕면"];
    // geocoding, geolocator가 기본적으로 제공하는 언어에 한글이 없음
    // Gyeonggi-do, Anseong-si, Daedeuk-myeon
    // 위와 같은 식으로 출력하기 때문에 이를 다시 한글로 바꾸는 것에 문제가 발생
  }
}
