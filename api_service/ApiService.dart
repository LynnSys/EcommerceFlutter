import 'dart:convert';
import 'dart:io';
import 'package:shopping/model/post.dart';
import 'package:http/http.dart' as http;

class ApiService{
  Future<List<Post>> getPosts() async{
    // List<Post> postData = [];
    // HttpClient client = HttpClient();

    var response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body)["products"] as List<dynamic>;
      return jsonData.map((e) => Post.fromJson(e)).toList();
    }
    else
    {
      return [];
    }
    // return postData;
  }
}