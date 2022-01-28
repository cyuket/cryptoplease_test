import 'package:cryptoplease/core/errors/errors.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:dartz/dartz.dart';

abstract class DataRepository {
  Future<Either<Failure, List<TokenModel>>> getListOfToken();
}
