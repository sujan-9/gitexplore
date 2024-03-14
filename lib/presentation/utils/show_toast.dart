import 'package:fluttertoast/fluttertoast.dart';
import 'package:githubexplore/app/utils/constants/pallets.dart';

showToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: redColor,
      textColor: whiteColor,
      fontSize: 16.0);
}
