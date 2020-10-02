import 'package:flutter_test/flutter_test.dart';
import 'package:rocket_launcher/data/network/mapper/api_to_domain_rocket_mapper.dart';
import 'package:rocket_launcher/data/network/model/api_rocket.dart';
import 'package:rocket_launcher/domain/model/rocket.dart';

void main() {
  final ApiToDomainRocketMapper sut = ApiToDomainRocketMapper();

  test("map SHOULD return mapped Rocket WHEN called", () {
    ApiRocket input = ApiRocket.makeRocket(name: "name");
    Rocket expected = Rocket.makeRocket(name: "name");

    Rocket result = sut.map(input);

    expect(result, expected);
  });
}
