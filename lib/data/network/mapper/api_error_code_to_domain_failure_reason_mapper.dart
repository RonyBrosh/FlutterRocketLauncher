import 'package:rocket_launcher/data/network/model/api_state.dart';
import 'package:rocket_launcher/data/util/mapper.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';

class ApiErrorCodeToDomainFailureReasonMapper implements Mapper<int, FailureReason> {
  @override
  FailureReason map(int input) {
    if (input >= 400 && input < 500) return FailureReason.CLIENT;
    if (input >= 500 && input < 600) return FailureReason.SERVER;
    if (input == API_ERROR_CODE_UNKNOWN) return FailureReason.UNKNOWN;
    if (input == API_ERROR_CODE_NETWORK) return FailureReason.NETWORK;
    return FailureReason.UNKNOWN;
  }
}
