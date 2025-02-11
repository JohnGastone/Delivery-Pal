import 'package:flutter/cupertino.dart';

class ResetMethodsModel {
  Icon? resetMethodIcon;
  String? resetMethod;
  String? resetPlaceholder;

  ResetMethodsModel(
      this.resetMethodIcon, this.resetMethod, this.resetPlaceholder);
}

class ResetMethodModelData {
  static List<ResetMethodsModel> getResetMethods = [
    ResetMethodsModel(
        const Icon(CupertinoIcons.chat_bubble), "Via SMS", "+255624839009"),
    ResetMethodsModel(
        const Icon(CupertinoIcons.mail), "Via Email", "john@protone.me"),
  ];
  static List<ResetMethodsModel> displayResetMethods =
      List.from(ResetMethodModelData.getResetMethods);
}
