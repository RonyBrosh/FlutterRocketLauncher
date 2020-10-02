import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rocket_launcher/data/network/api/rocket_api.dart';
import 'package:rocket_launcher/data/network/api_service/rocket_api_service_impl.dart';
import 'package:rocket_launcher/data/network/mapper/api_error_code_to_domain_failure_reason_mapper.dart';
import 'package:rocket_launcher/data/network/mapper/api_to_domain_rocket_mapper.dart';
import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/data/network/model/api_state.dart';
import 'package:rocket_launcher/data/util/mapper.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

class MockRocketApi extends Mock implements RocketApi {}

class MockApiToDomainRocketMapper extends Mock implements ApiToDomainRocketMapper {}

class MockApiErrorCodeToDomainFailureReasonMapper extends Mock implements ApiErrorCodeToDomainFailureReasonMapper {}

void main() {
  final RocketApi rocketApi = MockRocketApi();
  final Mapper<ApiRocket, Rocket> apiToDomainRocketMapper = MockApiToDomainRocketMapper();
  final Mapper<int, FailureReason> failureReasonMapper = MockApiErrorCodeToDomainFailureReasonMapper();
  final RocketApiServiceImpl sut = RocketApiServiceImpl(rocketApi, apiToDomainRocketMapper, failureReasonMapper);

  test("getRockets SHOULD return failure WHEN api return failure", () async {
    when(rocketApi.getRockets()).thenAnswer((_) => Future.value(ApiStateFailure(500)));

    ResultState<List<Rocket>> resultState = await sut.getRockets();

    expect(resultState, isA<ResultStateFailure>());
  });

  test("getRockets SHOULD return failure WHEN api fail", () async {
    Exception error = Exception("Can't fetch rockets");
    when(rocketApi.getRockets()).thenAnswer((_) => Future.error(error));
    when(failureReasonMapper.map(API_ERROR_CODE_UNKNOWN)).thenAnswer((_) => FailureReason.UNKNOWN);

    ResultState<List<Rocket>> resultState = await sut.getRockets();

    expect(resultState, isA<ResultStateFailure<List<Rocket>>>());
    expect((resultState as ResultStateFailure<List<Rocket>>).reason, FailureReason.UNKNOWN);
  });

  test("getRockets SHOULD return success with data WHEN api succeed", () async {
    ApiRocket apiRocket = ApiRocket.makeRocket();
    List<ApiRocket> response = [apiRocket];
    Rocket rocket = Rocket.makeRocket();
    List<Rocket> data = [rocket];
    when(apiToDomainRocketMapper.map(apiRocket)).thenAnswer((_) => rocket);
    when(rocketApi.getRockets()).thenAnswer((_) => Future.value(ApiStateSuccess<List<ApiRocket>>(response)));

    ResultState<List<Rocket>> resultState = await sut.getRockets();

    expect(resultState, isA<ResultStateSuccess<List<Rocket>>>());
    expect((resultState as ResultStateSuccess<List<Rocket>>).data, data);
  });
}
