import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

abstract class RocketApiService {
  Future<ResultState<List<Rocket>>> fetchRockets();
}
