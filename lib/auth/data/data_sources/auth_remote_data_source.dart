import 'package:else7a_tamam/core/network/error_message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/utilities/enums.dart';
import '../../domain/use_cases/login_with_email_usecase.dart';

abstract class BaseAuthRemoteDataSource {
  Future<User> loginWithEmail(AuthParams params);
  Future<User> registerWithEmail(AuthParams params);
  Future<void> logout();
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<User> loginWithEmail(AuthParams params) async {
    try {
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return user.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusMessage: e.message!,
          statusCode: int.parse(e.code),
          success: false,
        ),
      );
    }
  }

  @override
  Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<User> registerWithEmail(AuthParams params) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return user.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusMessage: e.message!,
          statusCode: int.parse(e.code),
          success: false,
        ),
      );
    }
  }
}
