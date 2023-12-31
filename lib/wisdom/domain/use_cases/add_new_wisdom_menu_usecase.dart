import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecase/base_usecase.dart';
import 'package:equatable/equatable.dart';

import '../repositories/base_wisdom_menu_repository.dart';

class AddNewWisdomMenuUseCase extends BaseUseCase<void, WisdomParams> {
  final BaseWisdomMenuRepository _baseWisdomMenuRepository;

  AddNewWisdomMenuUseCase(this._baseWisdomMenuRepository);

  @override
  Future<Either<Failure, void>> call(WisdomParams params) async {
    return await _baseWisdomMenuRepository.addNewWisdomMenu(params);
  }
}

class WisdomParams extends Equatable {
  final String name;
  final List<dynamic> subMenu;

  const WisdomParams({
    required this.name,
    required this.subMenu,
  });

  @override
  List<Object?> get props => [
        name,
        subMenu,
      ];
}
