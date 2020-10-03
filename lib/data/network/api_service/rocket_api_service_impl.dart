import 'package:rocket_launcher/data/network/api/rocket_api.dart';
import 'package:rocket_launcher/data/network/api_service/rocket_api_service.dart';
import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/data/network/model/api_state.dart';
import 'package:rocket_launcher/data/util/mapper.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

class RocketApiServiceImpl implements RocketApiService {
  RocketApiServiceImpl(RocketApi rocketApi, Mapper<ApiRocket, Rocket> apiToDomainRocketMapper, Mapper<int, FailureReason> failureReasonMapper)
      : _rocketApi = rocketApi,
        _apiToDomainRocketMapper = apiToDomainRocketMapper,
        _failureReasonMapper = failureReasonMapper;

  final RocketApi _rocketApi;
  final Mapper<ApiRocket, Rocket> _apiToDomainRocketMapper;
  final Mapper<int, FailureReason> _failureReasonMapper;

  @override
  Future<ResultState<List<Rocket>>> fetchRockets() async {
    ApiState<List<ApiRocket>> apiState = await _rocketApi.fetchRockets().catchError((error) {
      return ApiStateFailure<List<ApiRocket>>(API_ERROR_CODE_UNKNOWN);
    });

    if (apiState is ApiStateSuccess) {
      List<dynamic> dynamicList = (apiState as ApiStateSuccess).data.map((apiRocket) => _apiToDomainRocketMapper.map(apiRocket)).toList();
      List<Rocket> rockets = List<Rocket>.from(dynamicList);
      return ResultStateSuccess<List<Rocket>>(rockets);
    } else {
      return ResultStateFailure<List<Rocket>>(_failureReasonMapper.map((apiState as ApiStateFailure).errorCode));
    }
  }
}
