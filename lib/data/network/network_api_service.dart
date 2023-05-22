import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseAPIService {
  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connetion.");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      Response response = await post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connetion.");
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          return jsonDecode(response.body);
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnAuthorizedException(response.body.toString());

      default:
        throw FetchDataException(
            'Error occured while communicating with status Code ${response.statusCode}');
    }
  }
}
