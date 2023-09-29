import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecase/base_usecase.dart';
import '/wisdom/domain/repositories/base_wisdom_menu_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteSingleWisdomUseCase
    extends BaseUseCase<void, DeleteSingleWisdomParams> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  DeleteSingleWisdomUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, void>> call(DeleteSingleWisdomParams params) {
    return _baseWisdomMenuRepository.deleteSingleWisdom(params);
  }
}

class DeleteSingleWisdomParams extends Equatable {
  final String name;
  final String subMenu;

  const DeleteSingleWisdomParams({
    required this.name,
    required this.subMenu,
  });

  @override
  List<Object?> get props => [
        name,
        subMenu,
      ];
}
