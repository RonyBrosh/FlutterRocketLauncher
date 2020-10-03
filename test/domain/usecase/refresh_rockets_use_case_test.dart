import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';
import 'package:rocket_launcher/domain/repository/rocket_repository.dart';
import 'package:rocket_launcher/domain/usecase/refresh_rockets_use_case.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockRocketList extends Mock implements List<Rocket> {}

void main() {
  final RocketRepository rocketRepository = MockRocketRepository();
  final RefreshRocketsUseCase sut = RefreshRocketsUseCase(rocketRepository);

  test("invoke SHOULD return ResultState WHEN repository succeed", () async {
    when(rocketRepository.refreshRockets()).thenAnswer((_) => Future.value(ResultStateFailure(FailureReason.UNKNOWN)));

    ResultState<List<Rocket>> resultState = await sut();

    expect(resultState, isA<ResultState>());
  });

  test("invoke SHOULD return failure WHEN repository fail", () async {
    Exception error = Exception("Can't get rockets");
    when(rocketRepository.refreshRockets()).thenAnswer((_) => Future.error(error));

    ResultState<List<Rocket>> resultState = await sut();

    expect(resultState, isA<ResultStateFailure<List<Rocket>>>());
    expect((resultState as ResultStateFailure<List<Rocket>>).reason, FailureReason.UNKNOWN);
  });
}
