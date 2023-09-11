import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:else7a_tamam/core/error/exceptions.dart';
import 'package:else7a_tamam/core/network/error_message_model.dart';
import 'package:else7a_tamam/core/utilities/app_constance.dart';
import 'package:else7a_tamam/core/utilities/app_strings.dart';
import 'package:else7a_tamam/home/data/models/wisdom_menu_model.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain/use_cases/add_new_wisdom_menu_usecase.dart';

abstract class BaseWisdomRemoteDataSource {
  Future<List<WisdomMenuModel>> getWisdomMenu();
  Future<void> addNewWisdomMenu(WisdomParams params);
}

class WisdomRemoteDataSource extends BaseWisdomRemoteDataSource {
  @override
  Future<void> addNewWisdomMenu(WisdomParams params) async {
    WisdomMenuModel model = WisdomMenuModel(
      name: params.name,
      subMenu: params.subMenu,
    );
    try {
      await FirebaseFirestore.instance
          .collection("wisdom")
          .doc(model.name)
          .set(model.toJson());
    } on FirebaseException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusMessage: e.message ?? AppStrings.somethingWentWrong,
          statusCode: e.code,
          success: false,
        ),
      );
    }
  }

  @override
  Future<List<WisdomMenuModel>> getWisdomMenu() async {
    try {
      final result =
          await FirebaseFirestore.instance.collection("wisdom").get();
      return result.docs
          .map((e) => WisdomMenuModel.fromJson(e.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusMessage: e.message ?? AppStrings.somethingWentWrong,
          statusCode: e.code,
          success: false,
        ),
      );
    }
  }
}
