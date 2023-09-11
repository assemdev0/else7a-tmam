import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/wisdom_menu.dart';

class WisdomMenuModel extends WisdomMenu {
  const WisdomMenuModel({
    required super.name,
    required super.subMenu,
  });

  factory WisdomMenuModel.fromJson(Map<String, dynamic> json) {
    return WisdomMenuModel(
      name: json['name'],
      subMenu: json['subMenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'subMenu': FieldValue.arrayUnion(super.subMenu),
    };
  }
}
