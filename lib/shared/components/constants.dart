import 'package:flutter/material.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';

const KMainColor = Color(0XFFFFC12F);
const KSecondaryColor = Color(0XFFFFE6AC);

void signOut(context) {
  CashHelper.removeData(key: 'uId').then((value)
  {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String? uId;

String profileImage = '';