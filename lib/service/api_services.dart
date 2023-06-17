import 'dart:convert';

import 'package:auto_complete_widget/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future getUser() async {
    http.Response response = await http.get(
      Uri.parse("https://reqres.in/api/users?page=2"),
    );
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      print("===data===");
      print(decodeData);
      return UserModel.fromJson(decodeData);
    }
    print("===data===");
    print(response.body);
  }
}
