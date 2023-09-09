import 'package:dartz/dartz.dart';

import 'package:else7a_tamam/core/error/failures.dart';

import '../../../core/usecase/base_usecase.dart';
import '../repositories/base_auth_repository.dart';

class LogoutUseCase extends BaseUseCase<void, NoParams, Failure> {
  final BaseAuthRepository _baseAuthRepository;

  LogoutUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _baseAuthRepository.logout();
  }
}
