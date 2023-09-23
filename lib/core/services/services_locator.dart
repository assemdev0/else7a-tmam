import '/wisdom/data/data_sources/wisdom_remote_data_source.dart';
import '/wisdom/domain/repositories/base_wisdom_menu_repository.dart';
import '/wisdom/domain/use_cases/add_new_wisdom_menu_usecase.dart';
import '/wisdom/domain/use_cases/add_single_wisdom_usecase.dart';

import '../../auth/presentation/manager/auth_cubit.dart';
import '../../wisdom/data/repositories/wisdom_menu_repository.dart';
import '../../wisdom/domain/use_cases/get_wisdom_menu_usecase.dart';
import '/auth/data/data_sources/auth_remote_data_source.dart';
import '/auth/data/repositories/auth_repository.dart';
import '/auth/domain/repositories/base_auth_repository.dart';
import '/auth/domain/use_cases/login_with_email_usecase.dart';
import '/auth/domain/use_cases/logout_usecase.dart';
import '/auth/domain/use_cases/register_with_email_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    sl.registerFactory(() => AuthCubit());

    /// Use Cases
    // Auth
    sl.registerLazySingleton(() => LoginWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => RegisterWithEmailUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));

    // Wisdom
    sl.registerLazySingleton(() => GetWisdomMenuUseCase(sl()));
    sl.registerLazySingleton(() => AddNewWisdomMenuUseCase(sl()));
    sl.registerLazySingleton(() => AddSingleWisdomUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseWisdomMenuRepository>(
        () => WisdomMenuRepository(sl()));

    /// Data Source
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
    sl.registerLazySingleton<BaseWisdomRemoteDataSource>(
        () => WisdomRemoteDataSource());
  }
}
