import 'package:flutter_test/flutter_test.dart';
import 'package:rocket_launcher/data/network/mapper/api_error_code_to_domain_failure_reason_mapper.dart';
import 'package:rocket_launcher/data/network/model/api_state.dart';
import 'package:rocket_launcher/domain/model/result_state.dart';

void main() {
  final ApiErrorCodeToDomainFailureReasonMapper sut = ApiErrorCodeToDomainFailureReasonMapper();

  test("map SHOULD return mapped FailureReason.SERVER WHEN input between 500 to 600", () {
    int input = 500;
    FailureReason expected = FailureReason.SERVER;

    FailureReason result = sut.map(input);

    expect(result, expected);
  });

  test("map SHOULD return mapped FailureReason.CLIENT WHEN input between 400 to 500", () {
    int input = 400;
    FailureReason expected = FailureReason.CLIENT;

    FailureReason result = sut.map(input);

    expect(result, expected);
  });

  test("map SHOULD return mapped FailureReason.UNKNOWN WHEN input is API_ERROR_CODE_UNKNOWN", () {
    int input = API_ERROR_CODE_UNKNOWN;
    FailureReason expected = FailureReason.UNKNOWN;

    FailureReason result = sut.map(input);

    expect(result, expected);
  });

  test("map SHOULD return mapped FailureReason.UNKNOWN WHEN input is NETWORK", () {
    int input = API_ERROR_CODE_NETWORK;
    FailureReason expected = FailureReason.NETWORK;

    FailureReason result = sut.map(input);

    expect(result, expected);
  });

  test("map SHOULD return mapped FailureReason.UNKNOWN WHEN input is un supported error code", () {
    int input = -2349823498;
    FailureReason expected = FailureReason.UNKNOWN;

    FailureReason result = sut.map(input);

    expect(result, expected);
  });
}
