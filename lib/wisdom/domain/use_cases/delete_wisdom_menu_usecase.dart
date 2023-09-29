import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecase/base_usecase.dart';
import '/wisdom/domain/repositories/base_wisdom_menu_repository.dart';

class DeleteWisdomMenuUseCase extends BaseUseCase<void, String> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  DeleteWisdomMenuUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return _baseWisdomMenuRepository.deleteWisdomMenu(params);
  }
}
