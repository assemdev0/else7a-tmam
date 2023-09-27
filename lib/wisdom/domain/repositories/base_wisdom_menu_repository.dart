import 'package:dartz/dartz.dart';
import '../use_cases/delete_single_wisdom_usecase.dart';
import '/wisdom/domain/entities/wisdom_menu.dart';
import '/wisdom/domain/use_cases/add_new_wisdom_menu_usecase.dart';
import '/wisdom/domain/use_cases/add_single_wisdom_usecase.dart';

import '/core/error/failures.dart';

abstract class BaseWisdomMenuRepository {
  Future<Either<Failure, List<WisdomMenu>>> getWisdomMenu();
  Future<Either<Failure, void>> addNewWisdomMenu(WisdomParams params);
  Future<Either<Failure, void>> addSingleWisdom(SingleWisdomParams params);

  Future<Either<Failure, void>> deleteSingleWisdom(
      DeleteSingleWisdomParams params);

  Future<Either<Failure, void>> deleteWisdomMenu(String params);
}
