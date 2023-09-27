import 'package:dartz/dartz.dart';
import 'package:else7a_tamam/wisdom/domain/use_cases/delete_single_wisdom_usecase.dart';
import '/core/error/exceptions.dart';

import '/core/error/failures.dart';
import '/wisdom/data/data_sources/wisdom_remote_data_source.dart';
import '/wisdom/domain/entities/wisdom_menu.dart';

import '/wisdom/domain/use_cases/add_new_wisdom_menu_usecase.dart';

import '/wisdom/domain/use_cases/add_single_wisdom_usecase.dart';

import '../../domain/repositories/base_wisdom_menu_repository.dart';

class WisdomMenuRepository extends BaseWisdomMenuRepository {
  final BaseWisdomRemoteDataSource _baseWisdomMenuRemoteDataSource;

  WisdomMenuRepository(this._baseWisdomMenuRemoteDataSource);

  @override
  Future<Either<Failure, void>> addNewWisdomMenu(WisdomParams params) async {
    try {
      final result =
          await _baseWisdomMenuRemoteDataSource.addNewWisdomMenu(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> addSingleWisdom(
      SingleWisdomParams params) async {
    try {
      final result =
          await _baseWisdomMenuRemoteDataSource.addSingleWisdom(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<WisdomMenu>>> getWisdomMenu() async {
    try {
      final result = await _baseWisdomMenuRemoteDataSource.getWisdomMenu();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSingleWisdom(
      DeleteSingleWisdomParams params) async {
    try {
      final result =
          await _baseWisdomMenuRemoteDataSource.deleteSingleWisdom(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWisdomMenu(String params) async {
    try {
      final result =
          await _baseWisdomMenuRemoteDataSource.deleteWisdomMenu(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    }
  }
}
