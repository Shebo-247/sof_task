// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/reputation/repository/reputation_repository.dart'
    as _i493;
import '../../features/reputation/view_model/reputation_cubit.dart' as _i801;
import '../../features/users/repository/users_repository.dart' as _i252;
import '../../features/users/view_model/users_cubit.dart' as _i841;
import '../network/dio_client.dart' as _i667;
import '../services/storage_service.dart' as _i306;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i667.DioClient>(() => _i667.DioClient());
    gh.lazySingleton<_i306.StorageService>(() => _i306.StorageService());
    gh.lazySingleton<_i493.ReputationRepository>(
      () => _i493.ReputationRepository(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i252.UsersRepository>(
      () => _i252.UsersRepository(gh<_i667.DioClient>()),
    );
    gh.factory<_i801.ReputationCubit>(
      () => _i801.ReputationCubit(gh<_i493.ReputationRepository>()),
    );
    gh.factory<_i841.UsersCubit>(
      () => _i841.UsersCubit(
        gh<_i252.UsersRepository>(),
        gh<_i306.StorageService>(),
      ),
    );
    return this;
  }
}
