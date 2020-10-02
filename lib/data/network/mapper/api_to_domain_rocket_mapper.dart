import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';
import 'package:rocket_launcher/data/util/mapper.dart';

class ApiToDomainRocketMapper implements Mapper<ApiRocket, Rocket> {
  @override
  Rocket map(ApiRocket input) {
    return Rocket.makeRocket(
        id: input.id,
        name: input.name,
        country: input.country,
        description: input.description,
        images: input.images,
        enginesCount: input.enginesCount,
        isActive: input.isActive);
  }
}
