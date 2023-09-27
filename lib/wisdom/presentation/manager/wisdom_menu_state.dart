part of 'wisdom_menu_cubit.dart';

@immutable
abstract class WisdomMenuState {}

class WisdomMenuInitial extends WisdomMenuState {}

class GetWisdomMenuLoadingState extends WisdomMenuState {}

class GetWisdomMenuSuccessState extends WisdomMenuState {
  final List<WisdomMenu> wisdomMenu;

  GetWisdomMenuSuccessState(this.wisdomMenu);
}

class GetWisdomMenuErrorState extends WisdomMenuState {
  final String message;

  GetWisdomMenuErrorState(this.message);
}

class AddNewWisdomMenuLoadingState extends WisdomMenuState {}

class AddNewWisdomMenuSuccessState extends WisdomMenuState {}

class AddNewWisdomMenuErrorState extends WisdomMenuState {
  final String message;

  AddNewWisdomMenuErrorState(this.message);
}

class AddSingleWisdomLoadingState extends WisdomMenuState {}

class AddSingleWisdomSuccessState extends WisdomMenuState {}

class AddSingleWisdomErrorState extends WisdomMenuState {
  final String message;

  AddSingleWisdomErrorState(this.message);
}

class DeleteSingleWisdomLoadingState extends WisdomMenuState {}

class DeleteSingleWisdomSuccessState extends WisdomMenuState {}

class DeleteSingleWisdomErrorState extends WisdomMenuState {
  final String message;

  DeleteSingleWisdomErrorState(this.message);
}

class DeleteWisdomMenuLoadingState extends WisdomMenuState {}

class DeleteWisdomMenuSuccessState extends WisdomMenuState {}

class DeleteWisdomMenuErrorState extends WisdomMenuState {
  final String message;

  DeleteWisdomMenuErrorState(this.message);
}
