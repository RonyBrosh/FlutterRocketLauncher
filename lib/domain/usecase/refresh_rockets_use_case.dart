import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';
import 'package:rocket_launcher/domain/repository/rocket_repository.dart';

class RefreshRocketsUseCase {
  RefreshRocketsUseCase(RocketRepository rocketRepository) : _rocketRepository = rocketRepository;

  final RocketRepository _rocketRepository;

  Future<ResultState<List<Rocket>>> call() {
    return _rocketRepository.refreshRockets().catchError((error) {
      return ResultStateFailure<List<Rocket>>(FailureReason.UNKNOWN);
    });
  }
}