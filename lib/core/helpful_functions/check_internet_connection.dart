import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnection() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  return connectivityResult.any(
        (result) => result != ConnectivityResult.none,
  );
}