import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClass {
  static void getApiCall(data, onSucess, onError) {
    print("data =====>> $data");
    http
        .get(Uri.parse(data["url"]))
        .timeout(Duration(seconds: 15))
        .then((http.Response response) {
      if (response.statusCode < 200 ||
          response.statusCode >= 400 ||
          response == null) {
        onError({
          "status": 0,
          "message":
              response.statusCode == 404 ? "Url  Not Found" : response.body
        });
      } else {
        onSucess({"status": 1, "response": response.body});
      }
    }).catchError((error) {
      if (error is TimeoutException || error is SocketException) {
        onError({"status": -1, "message": "Please check internet connection"});
      }
    });
  }
}
