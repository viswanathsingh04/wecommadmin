import 'package:http/http.dart' as http;
import 'package:wecommadmin/models/login_model.dart';
import 'package:wecommadmin/services/shared_service.dart';

class Apiservices {
  static var client = http.Client();

  static Future<bool> checkLogin(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = new Uri.https(
      model.host,
      '/wp-json/wc/v3/products',
      {
        "consumer_key": model.key,
        "consumer_secret": model.secret,
      },
    );

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(model);
      return true;
    } else {
      return false;
    }
  }
}
