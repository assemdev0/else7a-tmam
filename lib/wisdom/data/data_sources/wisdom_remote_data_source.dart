import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/network/shared_preferences.dart';
import '/core/utilities/app_constance.dart';
import '/wisdom/domain/use_cases/delete_single_wisdom_usecase.dart';
import '/wisdom/domain/use_cases/add_single_wisdom_usecase.dart';
import '/core/network/error_message_model.dart';
import '/core/error/exceptions.dart';
import '/core/utilities/app_strings.dart';

import '../../domain/use_cases/add_new_wisdom_menu_usecase.dart';
import '../models/wisdom_menu_model.dart';

abstract class BaseWisdomRemoteDataSource {
  Future<List<WisdomMenuModel>> getWisdomMenu();
  Future<void> addNewWisdomMenu(WisdomParams params);
  Future<void> addSingleWisdom(SingleWisdomParams params);
  Future<void> deleteSingleWisdom(DeleteSingleWisdomParams params);

  Future<void> deleteWisdomMenu(String params);
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
      AppConstance.wisdomList = [];

      for (var element in result.docs) {
        final value = WisdomMenuModel.fromJson(element.data());
        AppConstance.wisdomList.add(json.encode(value.toMap()));
      }
      await SharedPref.setData(
          key: AppConstance.wisdomListKey, value: AppConstance.wisdomList);
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

  @override
  Future<void> addSingleWisdom(SingleWisdomParams params) {
    log(params.name);
    log(params.subMenu);
    try {
      return FirebaseFirestore.instance
          .collection('wisdom')
          .doc(params.name)
          .update({
            'subMenu': FieldValue.arrayUnion([params.subMenu])
          })
          .then((value) => log("Wisdom Added"))
          .catchError((error) => log("Failed to add Wisdom: $error"));
    } on FirebaseException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          success: false,
          statusMessage: e.message ?? AppStrings.somethingWentWrong,
          statusCode: e.code,
        ),
      );
    }
  }

  @override
  Future<void> deleteSingleWisdom(DeleteSingleWisdomParams params) {
    try {
      return FirebaseFirestore.instance
          .collection('wisdom')
          .doc(params.name)
          .update({
            'subMenu': FieldValue.arrayRemove([params.subMenu])
          })
          .then((value) => log("Wisdom Deleted"))
          .catchError((error) => log("Failed to delete Wisdom: $error"));
    } on FirebaseException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          success: false,
          statusMessage: e.message ?? AppStrings.somethingWentWrong,
          statusCode: e.code,
        ),
      );
    }
  }

  @override
  Future<void> deleteWisdomMenu(String params) {
    try {
      return FirebaseFirestore.instance
          .collection('wisdom')
          .doc(params)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          success: false,
          statusMessage: e.message ?? AppStrings.somethingWentWrong,
          statusCode: e.code,
        ),
      );
    }
  }
}
