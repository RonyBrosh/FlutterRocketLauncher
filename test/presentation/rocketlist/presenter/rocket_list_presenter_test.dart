import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';
import 'package:rocket_launcher/domain/usecase/refresh_rockets_use_case.dart';
import 'package:rocket_launcher/presentation/rocketlist/presenter/rocket_list_presenter.dart';
import 'package:rocket_launcher/presentation/rocketlist/view/rocket_list_view.dart';

class MockRocketListView extends Mock implements RocketListView {}

class MockRefreshRocketsUseCase extends Mock implements RefreshRocketsUseCase {}

void main() {
  final RocketListView rocketListView = MockRocketListView();
  final RefreshRocketsUseCase refreshRocketsUseCase = MockRefreshRocketsUseCase();
  final RocketListPresenter sut = RocketListPresenter(rocketListView, refreshRocketsUseCase);

  test("refreshRockets SHOULD toggle loading and showError WHEN refresh rockets use case return failure", () async {
    when(refreshRocketsUseCase()).thenAnswer((_) => Future.value(ResultStateFailure(FailureReason.NETWORK)));

    await sut.refreshRockets();

    verifyInOrder([rocketListView.toggleLoading(true), rocketListView.toggleLoading(false), rocketListView.showError(FailureReason.NETWORK)]);
  });

  test("refreshRockets SHOULD toggle loading and showError UNKNOWN WHEN refresh rockets use case fail", () async {
    when(refreshRocketsUseCase()).thenAnswer((_) => Future.error("Can't refresh rockets"));

    await sut.refreshRockets();

    verifyInOrder([rocketListView.toggleLoading(true), rocketListView.toggleLoading(false), rocketListView.showError(FailureReason.UNKNOWN)]);
  });

  test("refreshRockets SHOULD toggle loading and setRockets WHEN refresh rockets use case succeed", () async {
    List<Rocket> rockets = List();
    when(refreshRocketsUseCase()).thenAnswer((_) => Future.value(ResultStateSuccess(rockets)));

    await sut.refreshRockets();

    verifyInOrder([rocketListView.toggleLoading(true), rocketListView.toggleLoading(false), rocketListView.setRockets(rockets)]);
  });
}
