import 'package:cryptoplease/core/errors/failure.dart';
import 'package:cryptoplease/core/usecase/usecase.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:cryptoplease/feature/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWalletBalancesUsecase extends UseCase<List<TokenModel>, NoParams> {
  GetWalletBalancesUsecase({
    required this.dataRepository,
  });

  final DataRepository dataRepository;

  @override
  Future<Either<Failure, List<TokenModel>>> call(NoParams params) {
    return dataRepository.getListOfToken();
  }
}
