import 'package:cryptoplease/core/errors/error.dart';
import 'package:cryptoplease/core/errors/failure.dart';
import 'package:cryptoplease/feature/data/data_source/data_source.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:cryptoplease/feature/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DataRepository)
class DataRepositoryImpl extends DataRepository {
  DataRepositoryImpl({
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<TokenModel>>> getListOfToken() async {
    try {
      final response = await remoteDataSource.getAllCoins();
      return Right(response);
    } catch (e) {
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response!.data != null && e.response!.data != '') {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      return Left(UnknownFailure());
    }
  }
}
