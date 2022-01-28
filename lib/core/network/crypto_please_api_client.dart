import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'crypto_please_api_client.g.dart';

@RestApi()
abstract class CryptoPleaseApiClient {
  factory CryptoPleaseApiClient(
    Dio dio, {
    String baseUrl,
  }) = _CryptoPleaseApiClient;

  @GET('/coins/list')
  Future<HttpResponse> getList();
  @GET('/simple/price/')
  Future<HttpResponse> getPrice({
    @Query('ids') required String id,
    @Query('vs_currencies') required String currency,
  });
}
