import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';
import 'package:rocket_launcher/domain/usecase/refresh_rockets_use_case.dart';
import 'package:rocket_launcher/presentation/rocketlist/view/rocket_list_view.dart';

class RocketListPresenter {
  RocketListPresenter(RocketListView rocketListView, RefreshRocketsUseCase refreshRocketsUseCase)
      : _rocketListView = rocketListView,
        _refreshRocketsUseCase = refreshRocketsUseCase;

  final RocketListView _rocketListView;
  final RefreshRocketsUseCase _refreshRocketsUseCase;

  Future<void> refreshRockets() async {
    _rocketListView.toggleLoading(true);
    ResultState<List<Rocket>> resultState = await _refreshRocketsUseCase().catchError((error) {
      return ResultStateFailure<List<Rocket>>(FailureReason.UNKNOWN);
    });
    _rocketListView.toggleLoading(false);
    if (resultState is ResultStateSuccess)
      _handleRefreshRocketsSuccess(resultState as ResultStateSuccess);
    else
      _handleRefreshRocketsFailure(resultState as ResultStateFailure);
  }

  void _handleRefreshRocketsSuccess(ResultStateSuccess resultState) {
    _rocketListView.setRockets(resultState.data);
  }

  void _handleRefreshRocketsFailure(ResultStateFailure resultState) {
    _rocketListView.showError(resultState.reason);
  }
}
