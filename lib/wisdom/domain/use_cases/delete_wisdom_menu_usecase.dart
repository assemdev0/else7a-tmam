import 'package:dartz/dartz.dart';
import 'package:else7a_tamam/core/error/failures.dart';
import 'package:else7a_tamam/core/usecase/base_usecase.dart';
import 'package:else7a_tamam/wisdom/domain/repositories/base_wisdom_menu_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteWisdomMenuUseCase extends BaseUseCase<void, String> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  DeleteWisdomMenuUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return _baseWisdomMenuRepository.deleteWisdomMenu(params);
  }
}
