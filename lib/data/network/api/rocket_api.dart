import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/data/network/model/api_state.dart';

abstract class RocketApi {
  Future<ApiState<List<ApiRocket>>> fetchRockets();
}
