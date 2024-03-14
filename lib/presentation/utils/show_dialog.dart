import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_text.dart';

void showBackDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: CustomText.medium('Close the app'),
        content: CustomText.small('Are you sure you want to close the app?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Nevermind',
              style: TextStyle(
                  fontFamily: 'Lato', fontSize: 16, color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Leave',
              style: TextStyle(
                  fontFamily: 'Lato', fontSize: 18, color: Colors.red),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
}
