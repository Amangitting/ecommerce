import 'dart:convert';

import 'package:ecommerce/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  get({required String endPoint}) async {
    try {
      Response response = await http.get(Uri.parse(baseUrl + endPoint));

      return jsonDecode(response.body);
    } catch (e) {
      return {"error": e};
    }
  }

  post({required String endPoint, required Map<String, dynamic> body}) async {
    try {
      var response = await http.post(headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, Uri.parse(baseUrl + endPoint), body: jsonEncode(body));

      return jsonDecode(response.body);
    } catch (e) {
      return {"error": e};
    }
  }

  put({required String endPoint, required Map<String, dynamic> body}) async {
    try {
      var response = await http.put(headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, Uri.parse(baseUrl + endPoint), body: jsonEncode(body));

      return jsonDecode(response.body);
    } catch (e) {
      return {"error": e};
    }
  }
    delete({required String endPoint, required Map<String, dynamic> body}) async {
    try {
      var response = await http.delete(headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, Uri.parse(baseUrl + endPoint), body: jsonEncode(body));

      return jsonDecode(response.body);
    } catch (e) {
      return {"error": e};
    }
  }
}
