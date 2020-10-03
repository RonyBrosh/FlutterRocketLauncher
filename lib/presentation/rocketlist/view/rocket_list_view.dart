import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

abstract class RocketListView {
  void toggleLoading(bool isLoading);

  void setRockets(List<Rocket> rockets);

  void showError(FailureReason reason);
}
