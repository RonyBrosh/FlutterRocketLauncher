import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rocket_launcher/data/network/api/rocket_api_impl.dart';
import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/data/network/model/api_state.dart';

class MockClient extends Mock implements Client {}

void main() {
  test("fetchRockets SHOULD return Success WHEN api succeed", () async {
    RocketApiImpl sut = RocketApiImpl(Client());

    ApiState<List<ApiRocket>> apiState = await sut.fetchRockets();

    expect(apiState, isA<ApiStateSuccess<List<ApiRocket>>>());
  });

  test("fetchRockets SHOULD return Failure WHEN api fail", () async {
    int errorCode = 500;
    MockClient mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response('', errorCode));
    RocketApiImpl sut = RocketApiImpl(mockClient);

    ApiState<List<ApiRocket>> apiState = await sut.fetchRockets();

    expect(apiState, isA<ApiStateFailure<List<ApiRocket>>>());
    expect((apiState as ApiStateFailure<List<ApiRocket>>).errorCode, errorCode);
  });

  test("fetchRockets SHOULD return Failure with API_ERROR_CODE_UNKNOWN WHEN api return invalid response", () async {
    MockClient mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => http.Response('', 200));
    RocketApiImpl sut = RocketApiImpl(mockClient);

    ApiState<List<ApiRocket>> apiState = await sut.fetchRockets();

    expect(apiState, isA<ApiStateFailure<List<ApiRocket>>>());
    expect((apiState as ApiStateFailure<List<ApiRocket>>).errorCode, API_ERROR_CODE_UNKNOWN);
  });

  test("fetchRockets SHOULD return Failure with API_ERROR_CODE_NETWORK WHEN api return invalid response", () async {
    MockClient mockClient = MockClient();
    when(mockClient.get(any)).thenAnswer((_) async => throw ("Can't get rockets."));
    RocketApiImpl sut = RocketApiImpl(mockClient);

    ApiState<List<ApiRocket>> apiState = await sut.fetchRockets();

    expect(apiState, isA<ApiStateFailure<List<ApiRocket>>>());
    expect((apiState as ApiStateFailure<List<ApiRocket>>).errorCode, API_ERROR_CODE_NETWORK);
  });
}
