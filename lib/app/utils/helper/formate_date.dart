String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  return formattedDate;
}
