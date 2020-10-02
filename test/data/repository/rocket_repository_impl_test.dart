import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rocket_launcher/data/network/api_service/rocket_api_service.dart';
import 'package:rocket_launcher/data/repository/rocket_repository_impl.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

class MockRocketApiService extends Mock implements RocketApiService {}

class MockRocketList extends Mock implements List<Rocket> {}

void main() {
  final RocketApiService rocketApiService = MockRocketApiService();
  final RocketRepositoryImpl sut = RocketRepositoryImpl(rocketApiService);

  test("getRockets SHOULD return ResultState WHEN api service succeed", () async {
    when(rocketApiService.getRockets()).thenAnswer((_) => Future.value(ResultStateFailure(FailureReason.UNKNOWN)));

    ResultState<List<Rocket>> resultState = await sut.getRockets();

    expect(resultState, isA<ResultState>());
  });

  test("getRockets SHOULD return failure WHEN api service fail", () async {
    Exception error = Exception("Can't get rockets");
    when(rocketApiService.getRockets()).thenAnswer((_) => Future.error(error));

    ResultState<List<Rocket>> resultState = await sut.getRockets();

    expect(resultState, isA<ResultStateFailure<List<Rocket>>>());
    expect((resultState as ResultStateFailure<List<Rocket>>).reason, FailureReason.UNKNOWN);
  });
}
