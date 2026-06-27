import 'package:flutter/material.dart';

class AppPopup {

  //----------------------------------------------------------
  // Success Popup
  //----------------------------------------------------------

  static Future<void> success(

    BuildContext context,

    String title,

    String message,

  ) {

    return showDialog(

      context: context,

      barrierDismissible: false,

      builder: (_) {

        return AlertDialog(

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(15),

          ),

          title: Row(

            children: const [

              Icon(

                Icons.check_circle,

                color: Colors.green,

              ),

              SizedBox(width: 10),

              Text("Success"),

            ],

          ),

          content: Text(message),

          actions: [

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child: const Text("OK"),

            ),

          ],

        );

      },

    );

  }

  //----------------------------------------------------------
  // Error Popup
  //----------------------------------------------------------

  static Future<void> error(

    BuildContext context,

    String title,

    String message,

  ) {

    return showDialog(

      context: context,

      barrierDismissible: false,

      builder: (_) {

        return AlertDialog(

          shape: RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(15),

          ),

          title: Row(

            children: const [

              Icon(

                Icons.error,

                color: Colors.red,

              ),

              SizedBox(width: 10),

              Text("Error"),

            ],

          ),

          content: Text(message),

          actions: [

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child: const Text("OK"),

            ),

          ],

        );

      },

    );

  }

}