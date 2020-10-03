import 'package:rocket_launcher/data/network/api_service/rocket_api_service.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';
import 'package:rocket_launcher/domain/repository/rocket_repository.dart';

class RocketRepositoryImpl implements RocketRepository {
  RocketRepositoryImpl(RocketApiService rocketApiService) : _rocketApiService = rocketApiService;

  final RocketApiService _rocketApiService;

  @override
  Future<ResultState<List<Rocket>>> refreshRockets() {
    return _rocketApiService.fetchRockets().catchError((error) {
      return ResultStateFailure<List<Rocket>>(FailureReason.UNKNOWN);
    });
  }
}
