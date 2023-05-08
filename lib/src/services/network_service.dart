import 'dart:convert';

import 'package:deersolo/src/constants/api.dart';
import 'package:deersolo/src/models/post.dart';
import 'package:deersolo/src/models/product.dart';
import 'package:dio/dio.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;
  static final _dio = Dio();

  Future<List<Product>> getAllProduct() async {
    final url = '${API.BASE_URL}${API.PRODUCT}';
    //print(url);
    final Response response = await _dio.get(url);
    if(response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception('Network Failed');
  }
  Future<List<Post>> fetchPosts(int startIndex, {int limit = 10}) async {
    final url = 'https://jsonplaceholder.typicode.com/posts?_start=1&_limit=9';
    final Response response = await _dio.get(url);
    if(response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    }
    throw Exception('Network Failed');
  }
}
