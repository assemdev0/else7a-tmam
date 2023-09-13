import 'package:equatable/equatable.dart';

class WisdomMenu extends Equatable {
  final String name;
  final List<dynamic> subMenu;

  const WisdomMenu({
    required this.name,
    required this.subMenu,
  });

  @override
  List<Object?> get props => [
        name,
        subMenu,
      ];
}
