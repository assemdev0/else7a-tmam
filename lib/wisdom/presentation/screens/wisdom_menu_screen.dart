import '/wisdom/presentation/manager/wisdom_menu_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/wisdom_menu_error_widget.dart';
import '../widgets/wisdom_menu_success_widget.dart';
import '/core/utilities/app_strings.dart';
import 'package:flutter/material.dart';

class WisdomMenuScreen extends StatelessWidget {
  const WisdomMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WisdomMenuCubit()..getWisdomMenu(context),
      child: BlocConsumer<WisdomMenuCubit, WisdomMenuState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetWisdomMenuLoadingState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.home),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GetWisdomMenuErrorState) {
            return WisdomMenuErrorWidget(
              message: state.message,
            );
          } else if (state is GetWisdomMenuSuccessState) {
            return WisdomMenuSuccessWidget(
              state: state,
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.home),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
