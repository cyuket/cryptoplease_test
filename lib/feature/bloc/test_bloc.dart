import 'package:cryptoplease/core/injections/injections.dart';
import 'package:cryptoplease/core/usecase/usecase.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:cryptoplease/feature/domain/usecases/token_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TestBlocEvent {}

/// Notifies bloc to increment state.
class CounterIncrementPressed extends TestBlocEvent {}

/// Notifies bloc to decrement state.

class TestBloc extends Bloc<TestBlocEvent, List<TokenModel>> {
  TestBloc() : super([]) {
    on<CounterIncrementPressed>((event, emit) async {
      final result = await sl<GetWalletBalancesUsecase>().call(NoParams());
      var list = <TokenModel>[];
      result.fold((l) => null, (r) => list = r);
      emit(list);
    });
  }
}
