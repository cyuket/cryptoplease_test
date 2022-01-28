import 'package:cryptoplease/core/errors/error.dart';
import 'package:cryptoplease/core/network/crypto_please_api_client.dart';
import 'package:cryptoplease/core/network/network_info.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:injectable/injectable.dart';

abstract class RemoteDataSource {
  Future<List<TokenModel>> getAllCoins();
}

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({
    required this.networkInfo,
    required this.dio,
  }) : super() {
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print, // retry count (optional)
        retryDelays: const [
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
          Duration(seconds: 3), // wait 3 sec before third retry
        ],
      ),
    );
    client = CryptoPleaseApiClient(
      dio,
      baseUrl: 'https://api.coingecko.com/api/v3',
    );
  }
  final NetworkInfo networkInfo;

  final Dio dio;
  late final CryptoPleaseApiClient client;

  @override
  Future<List<TokenModel>> getAllCoins() async {
    if (await networkInfo.isConnected) {
      final result = await client.getList();
      final list = <TokenModel>[];
      for (var i = 0; i < 5; i++) {
        final token = TokenModel.fromJson(result.response.data[i]);
        final price = await client.getPrice(id: token.id, currency: 'USD');
        token.price = price.response.data[token.id]['usd'];
        list.add(token);
      }

      return list;
    } else {
      throw NoInternetException();
    }
  }
}
