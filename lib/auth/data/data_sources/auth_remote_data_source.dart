import 'dart:developer';

import '/core/network/error_message_model.dart';
import '/core/utilities/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../domain/use_cases/login_with_email_usecase.dart';

abstract class BaseAuthRemoteDataSource {
  Future<User> loginWithEmail(AuthParams params);
  Future<User> registerWithEmail(AuthParams params);
  Future<NoParams> logout();
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<User> loginWithEmail(AuthParams params) async {
    debugPrint(params.email);
    debugPrint(params.password);
    // final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: params.email,
    //   password: params.password,
    // );
    // if (user.user != null) {
    //   return user.user!;
    // } else {
    //   log("FirebaseAuthException: Something went wrong");
    //   throw FirebaseAuthException(code: user.credential.toString()
    //       // errorMessageModel: const ErrorMessageModel(
    //       //   statusMessage: "Something went wrong",
    //       //   statusCode: "FirebaseAuthException",
    //       //   success: false,
    //       // ),
    //       );
    // }

    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return user.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw ServerException(
            errorMessageModel: const ErrorMessageModel(
          statusMessage: "No user found for that email.",
          statusCode: "user-not-found",
          success: false,
        ));
      } else if (e.code == "wrong-password") {
        throw ServerException(
            errorMessageModel: const ErrorMessageModel(
          statusMessage: "كلمة المرور غير صحيحة",
          statusCode: "wrong-password",
          success: false,
        ));
      } else {
        throw ServerException(
            errorMessageModel: ErrorMessageModel(
          statusMessage: AppStrings.somethingWentWrong,
          statusCode: e.code,
          success: false,
        ));
      }
    }
  }

  @override
  Future<NoParams> logout() async {
    try {
      final result = await FirebaseAuth.instance.signOut();

      return const NoParams();
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusMessage: AppStrings.somethingWentWrong,
          statusCode: e.code,
          success: false,
        ),
      );
    }
  }

  @override
  Future<User> registerWithEmail(AuthParams params) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return user.user!;
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: Something went wrong");
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusMessage: AppStrings.somethingWentWrong,
          statusCode: e.code,
          success: false,
        ),
      );
    }
  }
}
