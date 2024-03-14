import 'package:html/parser.dart' as html_parser;

String extractPlainText(String htmlString) {
  htmlString = htmlString.replaceAll(
      RegExp(r'\[!\[Discord badge]\[.*?\]\(.*?\)\]\(.*?\)'), '');
  var document = html_parser.parse(htmlString);
  String plainText = document.querySelector('body')!.text;
  return plainText;
}
