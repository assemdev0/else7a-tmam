import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/wisdom_menu.dart';
import '../repositories/base_wisdom_menu_repository.dart';

class GetWisdomMenuUseCase
    extends BaseUseCase<List<WisdomMenu>, NoParams, Failure> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  GetWisdomMenuUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, List<WisdomMenu>>> call(NoParams params) async {
    return await _baseWisdomMenuRepository.getWisdomMenu();
  }
}
