// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;

import '../../feature/data/data_source/data_source.dart' as _i6;
import '../../feature/data/repository/repository_imp.dart' as _i8;
import '../../feature/domain/repository/repository.dart' as _i7;
import '../../feature/domain/usecases/token_list_usecase.dart' as _i9;
import '../network/network_info.dart' as _i5;
import 'register_module.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Dio>(() => registerModule.dio);
  gh.factory<_i4.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i5.NetworkInfo>(
      () => _i5.NetworkInfoImpl(get<_i4.InternetConnectionChecker>()));
  gh.lazySingleton<_i6.RemoteDataSource>(() => _i6.RemoteDataSourceImpl(
      networkInfo: get<_i5.NetworkInfo>(), dio: get<_i3.Dio>()));
  gh.lazySingleton<_i7.DataRepository>(() =>
      _i8.DataRepositoryImpl(remoteDataSource: get<_i6.RemoteDataSource>()));
  gh.lazySingleton<_i9.GetWalletBalancesUsecase>(() =>
      _i9.GetWalletBalancesUsecase(dataRepository: get<_i7.DataRepository>()));
  return get;
}

class _$RegisterModule extends _i10.RegisterModule {}
