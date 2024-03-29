import 'dart:convert';
import 'dart:io';

import 'package:deersolo/src/constants/api.dart';
import 'package:deersolo/src/models/post.dart';
import 'package:deersolo/src/models/product.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;
  static final _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.baseUrl = API.BASE_URL;
          print(options.baseUrl+options.path);

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError err, ErrorInterceptorHandler handler) {
          return handler.next(err);
        },
      ),
    );

  Future<List<Product>> getAllProduct() async {
    final url = API.PRODUCT;
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception('Network Failed');
  }

  Future<String> addProduct({required Product product, File? imageFile} ) async {
    final url = API.PRODUCT;

    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if(imageFile != null)
        'photo': await MultipartFile.fromFile(
            imageFile.path,
          contentType: MediaType('image', 'jpg')
        )
    });

    final Response response = await _dio.post(url, data: data);
    if (response.statusCode == 201) {
      return "ADD OK .......";
    }
    throw Exception('Network Failed');
  }
  Future<String> editProduct({required Product product, File? imageFile} ) async {
    final url = '${API.PRODUCT}/${product.id}';

    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if(imageFile != null)
        'photo': await MultipartFile.fromFile(
            imageFile.path,
            contentType: MediaType('image', 'jpg')
        )
    });

    final Response response = await _dio.put(url, data: data);
    if (response.statusCode == 200) {
      return "Edit Success .......";
    }
    throw Exception('Network Failed');
  }

  Future<String> deleteProduct(int? productId) async {
    final url = '${API.PRODUCT}/$productId';
    final Response response = await _dio.delete(url);
    if (response.statusCode == 204) {
      return "Delete Success .......";
    }
    throw Exception('Network Failed');
  }


  /////////////////////////////do not use///////////////////////////////////////////////////////
  Future<List<Post>> fetchPosts(int startIndex, {int limit = 10}) async {
    final url = 'https://jsonplaceholder.typicode.com/posts?_start=1&_limit=9';
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    }
    throw Exception('Network Failed');
  }
}
