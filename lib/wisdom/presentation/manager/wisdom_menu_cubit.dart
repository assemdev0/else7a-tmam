import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import '/auth/presentation/screens/login_screen.dart';
import '/core/usecase/base_usecase.dart';
import '/wisdom/presentation/screens/add_new_wisdom.dart';
import '/wisdom/presentation/screens/wisdom_menu_screen.dart';

import '../../../core/global/widgets/default_dialog.dart';
import '../../../core/utilities/app_strings.dart';
import '../screens/wisdom_screen.dart';
import '/wisdom/domain/use_cases/add_new_wisdom_menu_usecase.dart';
import '/wisdom/domain/use_cases/add_single_wisdom_usecase.dart';
import '/wisdom/presentation/screens/add_new_wisdom_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/services/services_locator.dart';
import '/wisdom/domain/entities/wisdom_menu.dart';
import '/wisdom/domain/use_cases/get_wisdom_menu_usecase.dart';

part 'wisdom_menu_state.dart';

class WisdomMenuCubit extends Cubit<WisdomMenuState> {
  WisdomMenuCubit() : super(WisdomMenuInitial());

  static WisdomMenuCubit get(BuildContext context) => BlocProvider.of(context);

  /// Use Cases
  final GetWisdomMenuUseCase _getWisdomMenuUseCase = sl();
  final AddNewWisdomMenuUseCase _addNewWisdomMenuUseCase = sl();
  final AddSingleWisdomUseCase _addSingleWisdomUseCase = sl();

  /// Add New Wisdom Menu Controllers
  final wisdomMenuNameController = TextEditingController();
  final wisdomNameController = TextEditingController();
  final newWisdomController = TextEditingController();

  /// Get Wisdom Menu
  getWisdomMenu(BuildContext context) async {
    emit(GetWisdomMenuLoadingState());
    final result = await _getWisdomMenuUseCase(const NoParams());
    result.fold(
      (l) {
        log(l.message);
        if (l.message.contains('does not have permission')) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
              (route) => false);
        }
        emit(GetWisdomMenuErrorState(l.message));
      },
      (r) => emit(GetWisdomMenuSuccessState(r)),
    );
  }

  onWisdomClicked({
    required BuildContext context,
    required WisdomMenu wisdom,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WisdomScreen(
          wisdom: wisdom,
        ),
      ),
    );
  }

  onNewWisdomMenuClicked(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const AddNewWisdomMenuScreen()));
  }

  addNewWisdomMenu(BuildContext context) async {
    final params = WisdomParams(
      name: wisdomMenuNameController.text,
      subMenu: [wisdomNameController.text],
    );
    final result = await _addNewWisdomMenuUseCase(params);

    result.fold(
      (l) {
        defaultAppDialog(
          context: context,
          dialogType: DialogType.error,
          title: AppStrings.error,
          desc: l.message,
          btnOkOnPress: () {},
        ).show();
        emit(AddNewWisdomMenuErrorState(l.message));
      },
      (r) {
        defaultAppDialog(
          context: context,
          dialogType: DialogType.success,
          title: AppStrings.success,
          desc: AppStrings.addNewWisdomMenuSuccessfully,
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const WisdomMenuScreen(),
                ),
                (route) => false);
          },
        ).show();
        emit(AddNewWisdomMenuSuccessState());
      },
    );
  }

  addNewWisdom({
    required String name,
    required BuildContext context,
  }) async {
    emit(AddSingleWisdomLoadingState());
    final params = SingleWisdomParams(
      name: name,
      subMenu: newWisdomController.text,
    );
    final result = await _addSingleWisdomUseCase(params);
    result.fold(
      (l) {
        defaultAppDialog(
          context: context,
          dialogType: DialogType.error,
          title: AppStrings.error,
          desc: l.message,
          btnOkOnPress: () {},
        ).show();

        emit(AddSingleWisdomErrorState(l.message));
      },
      (r) {
        defaultAppDialog(
          context: context,
          dialogType: DialogType.success,
          title: AppStrings.success,
          desc: AppStrings.wisdomAddedSuccessfully,
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const WisdomMenuScreen(),
                ),
                (route) => false);
          },
        ).show();
        emit(AddSingleWisdomSuccessState());
      },
    );
  }

  onAddNewSingleWisdomClicked({
    required BuildContext context,
    required String name,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddNewWisdom(
          name: name,
        ),
      ),
    );
  }
}
