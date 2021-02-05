import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testDemo/user_model.dart';

///
/// Create Presenter to call api and get the data
///

class GetUserinfoPresenter {
  GetUserinfoListener listListener;
  GetUserinfoPresenter(this.listListener);

  getuserInfo() async {
    try {
      var url = 'https://jsonplaceholder.typicode.com/users';
      var response = await http.get(
        url,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      final data = jsonDecode(response.body);

      List<User> aUser = [];
      if (data is List) {
        data.forEach((element) {
          aUser.add(User.fromJson(element, 1));
          aUser.add(User.fromJson(element, 100));
          aUser.add(User.fromJson(element, 200));
          aUser.add(User.fromJson(element, 300));
          aUser.add(User.fromJson(element, 400));
        });
      }

      print(aUser);
      listListener.showData(aUser: aUser, msg: aUser.length.toString());
    } on Exception {
      listListener.showMSG("");
    }
  }
}

abstract class GetUserinfoListener {
  void showData({var msg, List<User> aUser});
  void showMSG(var msg);
}

_getList() {}
