import 'package:dartz/dartz.dart';
import '/auth/data/data_sources/auth_remote_data_source.dart';
import '/auth/domain/repositories/base_auth_repository.dart';
import '/auth/domain/use_cases/login_with_email_usecase.dart';
import '/core/error/exceptions.dart';
import '/core/error/failures.dart';
import '/core/usecase/base_usecase.dart';
import '/core/utilities/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource _baseAuthRemoteDataSource;

  AuthRepository(this._baseAuthRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmail(AuthParams params) async {
    final result = await _baseAuthRemoteDataSource.loginWithEmail(params);
    try {
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(AppStrings.somethingWrong),
      );
    }
  }

  @override
  Future<Either<Failure, NoParams>> logout() async {
    final result = await _baseAuthRemoteDataSource.logout();
    try {
      return const Right(NoParams());
    } on ServerException {
      return const Left(
        ServerFailure(AppStrings.somethingWrong),
      );
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmail(AuthParams params) async {
    final result = await _baseAuthRemoteDataSource.registerWithEmail(params);
    try {
      return Right(result);
    } on ServerException {
      return const Left(
        ServerFailure(AppStrings.somethingWrong),
      );
    }
  }
}
