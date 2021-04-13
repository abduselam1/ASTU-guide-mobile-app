import 'package:connectivity/connectivity.dart';

class Connection{

  Future<bool> isConnected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none) ? true : true; // tobe changed to the revers order
  }

}