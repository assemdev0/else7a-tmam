import '/auth/data/data_sources/auth_remote_data_source.dart';
import '/auth/data/repositories/auth_repository.dart';
import '/auth/domain/repositories/base_auth_repository.dart';
import '/auth/domain/use_cases/login_with_email_usecase.dart';
import '/auth/domain/use_cases/logout_usecase.dart';
import '/auth/domain/use_cases/register_with_email_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../auth/presentation/manager/auth_manager.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Providers
    sl.registerFactory(() => AuthManager());

    /// Use Cases
    sl.registerLazySingleton(() => LoginWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => RegisterWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));

    /// Data Source
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
  }
}
