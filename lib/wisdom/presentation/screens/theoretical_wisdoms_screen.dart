import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:else7a_tamam/wisdom/data/models/wisdom_menu_model.dart';
import 'package:flutter/material.dart';

import '../../../auth/presentation/manager/auth_cubit.dart';
import 'wisdom_screen.dart';

class TheoreticalWisdomsScreen extends StatefulWidget {
  const TheoreticalWisdomsScreen({Key? key}) : super(key: key);

  @override
  State<TheoreticalWisdomsScreen> createState() =>
      _TheoreticalWisdomsScreenState();
}

class _TheoreticalWisdomsScreenState extends State<TheoreticalWisdomsScreen> {
  Future<WisdomMenuModel> _getTheoreticalWisdoms() async {
    final result = await FirebaseFirestore.instance
        .collection('wisdom')
        .doc('النظري')
        .get();
    if (result.data() != null) {
      return WisdomMenuModel.fromJson(result.data()!);
    } else {
      return const WisdomMenuModel(
        name: 'النظري',
        subMenu: [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTheoreticalWisdoms(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.theoretical),
              actions: [
                IconButton(
                  onPressed: () => AuthCubit.get(context).logout(context),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return WisdomScreen(
            wisdom: snapshot.data!,
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.theoretical),
              actions: [
                IconButton(
                  onPressed: () => AuthCubit.get(context).logout(context),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
