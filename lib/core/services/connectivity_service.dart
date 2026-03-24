import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService(this._connectivity);

  final Connectivity _connectivity;

  Stream<bool> watchOnlineStatus() {
    return _connectivity.onConnectivityChanged.map(
      (result) => result.any((item) => item != ConnectivityResult.none),
    );
  }
}

