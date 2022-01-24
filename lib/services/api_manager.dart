import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_02/constant/strings.dart';
import 'package:news_app_02/models/newsinfo.dart';

class API_manager {

  Future<Newsmodel> topNews() async {
    var client = http.Client();
    var topnewsModel;
    try {
      var response = await client.get(Uri.parse('https://newsapi.org/v2/everything?category=sport&language=en&sortBy=popularity&apiKey=d28393faa351489fba5dc2578609c39b'));
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

    return topnewsModel ?? 'error';
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