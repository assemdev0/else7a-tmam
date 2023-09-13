import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/base_usecase.dart';
import '../repositories/base_wisdom_menu_repository.dart';

class AddSingleWisdomUseCase extends BaseUseCase<void, SingleWisdomParams> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  AddSingleWisdomUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, void>> call(SingleWisdomParams params) async {
    return await _baseWisdomMenuRepository.addSingleWisdom(params);
  }
}

class SingleWisdomParams extends Equatable {
  final String name;
  final String subMenu;

  const SingleWisdomParams({
    required this.name,
    required this.subMenu,
  });

  @override
  List<Object?> get props => [
        name,
        subMenu,
      ];
}
