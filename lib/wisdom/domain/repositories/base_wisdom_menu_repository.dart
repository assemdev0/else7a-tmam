import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/wisdom_menu.dart';
import '../use_cases/add_new_wisdom_menu_usecase.dart';

abstract class BaseWisdomMenuRepository {
  Future<Either<Failure, List<WisdomMenu>>> getWisdomMenu();
  Future<Either<Failure, void>> addNewWisdomMenu(WisdomParams params);
}
