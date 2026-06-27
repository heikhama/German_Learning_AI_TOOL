import 'package:flutter/material.dart';

import '../widgets/app_popup.dart';

class PopupService {

  static Future<void> success(

    BuildContext context,

    String message,

  ) async {

    await AppPopup.success(

      context,

      "Success",

      message,

    );

  }

  //----------------------------------------------------------

  static Future<void> error(

    BuildContext context,

    String message,

  ) async {

    await AppPopup.error(

      context,

      "Error",

      message,

    );

  }

}