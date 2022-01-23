import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_02/constant/strings.dart';
import 'package:news_app_02/models/newsinfo.dart';

class API_manager {

  Future<Newsmodel> topNews() async {
    var client = http.Client();
    var topnewsModel;
    try {
      var response = await client.get(Uri.parse(Strings.top_news));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);

        topnewsModel = Newsmodel.fromJson(jsonMap);
        print(jsonMap);
      } else {
        print('failed with: ${response.statusCode}');
      }
    } catch (Exception) {
      return topnewsModel;
    }

    return topnewsModel;
  }

 
}

// class API_manager02 {
//  Future<Newsmodel> everythingNews() async {
//     var client = http.Client();
//     var everynewsModel;
//     try {
//       var response = await client.get(Uri.parse(Strings.everything_news));
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         var jsonMap = jsonDecode(jsonString);

//         everynewsModel = Newsmodel.fromJson(jsonMap);
//         print(jsonMap);
//       } else {
//         print('failed with: ${response.statusCode}');
//       }
//     } catch (Exception) {
//       return everynewsModel;
//     }

//     return everynewsModel;
//   }
//   }