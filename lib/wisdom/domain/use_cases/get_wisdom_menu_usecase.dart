import 'package:dartz/dartz.dart';

import '/core/error/failures.dart';
import '/core/usecase/base_usecase.dart';
import '/wisdom/domain/entities/wisdom_menu.dart';
import '/wisdom/domain/repositories/base_wisdom_menu_repository.dart';

class GetWisdomMenuUseCase extends BaseUseCase<List<WisdomMenu>, NoParams> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  GetWisdomMenuUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, List<WisdomMenu>>> call(NoParams params) async {
    return await _baseWisdomMenuRepository.getWisdomMenu();
  }
}
