import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

abstract class RocketRepository {
  Future<ResultState<List<Rocket>>> refreshRockets();
}
