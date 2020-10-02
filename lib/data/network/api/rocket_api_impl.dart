import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:rocket_launcher/data/network/api/rocket_api.dart';
import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/data/network/model/api_state.dart';

class RocketApiImpl extends RocketApi {
  RocketApiImpl(Client client) : _client = client;

  final Client _client;

  @override
  Future<ApiState<List<ApiRocket>>> getRockets() async {
    try {
      final response = await _client.get('https://api.spacexdata.com/v4/rockets');
      if (response.statusCode == 200) {
        try {
          return ApiStateSuccess<List<ApiRocket>>(_parseRockets(response));
        } catch (exception) {
          return ApiStateFailure<List<ApiRocket>>(API_ERROR_CODE_UNKNOWN);
        }
      } else {
        return ApiStateFailure<List<ApiRocket>>(response.statusCode);
      }
    } catch (exception) {
      return ApiStateFailure<List<ApiRocket>>(API_ERROR_CODE_NETWORK);
    }
  }

  List<ApiRocket> _parseRockets(Response response) {
    List<ApiRocket> apiRockets = [];
    List<dynamic> data = json.decode(response.body);
    data.forEach((element) {
      List<dynamic> flickrImages = element['flickr_images'];
      List<String> images = [];
      flickrImages.forEach((element) {
        images.add(element);
      });
      apiRockets.add(ApiRocket.makeRocket(
          id: element['id'],
          name: element['name'],
          country: element['country'],
          description: element['description'],
          images: images,
          enginesCount: element['engines']['number'],
          isActive: element['active']));
    });
    return apiRockets;
  }
}
