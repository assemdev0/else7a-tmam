import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/network/shared_prefrences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/services/services_locator.dart';
import 'core/utilities/app_constance.dart';
import 'core/utilities/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  Bloc.observer = AppBlocObserver();
  await SharedPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppConstance.userType =
      SharedPref.getData(key: AppConstance.userTypeKey) ?? '';
  AppConstance.uId = SharedPref.getData(key: AppConstance.uIdKey) ?? '';

  runApp(const MyApp());
}
