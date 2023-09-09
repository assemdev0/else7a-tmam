import 'dart:developer';

import 'package:else7a_tamam/core/network/error_message_model.dart';
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
          statusMessage: "Wrong password provided for that user.",
          statusCode: "wrong-password",
          success: false,
        ));
      } else {
        throw ServerException(
            errorMessageModel: const ErrorMessageModel(
          statusMessage: "Something went wrong",
          statusCode: "FirebaseAuthException",
          success: false,
        ));
      }
    }
  }

  @override
  Future<NoParams> logout() async {
    final result = await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.signOut() is VoidCallbackAction) {
      return const NoParams();
    } else {
      throw ServerException(
        errorMessageModel: const ErrorMessageModel(
          statusMessage: "Something went wrong",
          statusCode: "FirebaseAuthException",
          success: false,
        ),
      );
    }
  }

  @override
  Future<User> registerWithEmail(AuthParams params) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    if (user.user != null) {
      return user.user!;
    } else {
      log("FirebaseAuthException: Something went wrong");
      throw ServerException(
        errorMessageModel: const ErrorMessageModel(
          statusMessage: "Something went wrong",
          statusCode: "FirebaseAuthException",
          success: false,
        ),
      );
    }
  }
}
