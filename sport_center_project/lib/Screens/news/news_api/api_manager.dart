import 'dart:convert';

import 'package:http/http.dart';
import 'package:sport_center_project/Screens/news/news_api/soccermodel.dart';
class SoccerApi {
  //now let's set our variables
  //first : let's add the endpoint URL
  // we will get all the data from api-sport.io
  // we will just change our endpoint
  //the null means that the match didn't started yet
  //let's fix that
  final Uri apiUrl = Uri.parse("https://api-football-v1.p.rapidapi.io/v3/fixtures?live=all");
  //In our tutorial we will only see how to get the live matches
  //make sure to read the api documentation to be ables too understand it

  // you will find your api key in your dashboard
  //so create your account it's free
  //Now let's add the headers
  static const headers = {
    'x-rapidapi-host': "api-football-v1.p.rapidapi.com",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': "7677dda70123483dbfb39118dc337c1a"

  };

  //Now we will create our method
  //but before this we need to create our model

  //Now we finished with our Model
  Future<List<SoccerMatch>> getAllMatches() async {
    Response res = await get(apiUrl, headers: headers);
    var body;

    if (res.statusCode == 200) {
      body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Api service: ${body}"); // to debug
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    }

    // If there is an error, throw an exception or return an empty list
    // or any default value that makes sense for your application
    throw Exception("Failed to load matches");
  }
}