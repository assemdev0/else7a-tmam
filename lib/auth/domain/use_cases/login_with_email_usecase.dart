import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/base_auth_repository.dart';
import '/core/usecase/base_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';

class LoginWithEmailUseCase extends BaseUseCase {
  final BaseAuthRepository _baseAuthRepository;

  LoginWithEmailUseCase(this._baseAuthRepository);

  @override
  Future<Either<Failure, User>> call(AuthParams params) async {
    return await _baseAuthRepository.loginWithEmail(params);
  }
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
