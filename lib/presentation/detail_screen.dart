import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_appbar.dart';
import 'package:githubexplore/app/utils/constants/app_strings.dart';
import 'package:githubexplore/app/utils/constants/sizes.dart';
import 'package:githubexplore/model/github_repo_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class DetailScreen extends StatefulWidget {
  final GithubRepoModel data;

  const DetailScreen({
    super.key,
    required this.data,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String encodedData = ''' ''';
  bool isLoading = true;
  String plainText = ''' ''';
  String decodedData = ''' ''';

  @override
  void initState() {
    super.initState();
    fetchReadme();
  }

  Future<void> fetchReadme() async {
    String readmeUrl =
        'https://api.github.com/repos/${widget.data.userName}/${widget.data.repoName}/readme';

    try {
      final response = await http.get(Uri.parse(readmeUrl));
      if (response.statusCode == 200) {
        final readmeData = jsonDecode(response.body);
        setState(() {
          encodedData = readmeData['content'];
          isLoading = false;

          decodedData = utf8.decode(
              base64.decode(encodedData.replaceAll(RegExp(r'\s+'), '')));
        });
        plainText = extractPlainText(decodedData);
      } else {
        throw Exception('Failed to load imagdatae');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String extractPlainText(String htmlString) {
    htmlString = htmlString.replaceAll(
        RegExp(r'\[!\[Discord badge]\[.*?\]\(.*?\)\]\(.*?\)'), '');
    var document = html_parser.parse(htmlString);
    String plainText = document.querySelector('body')!.text;
    return plainText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.detailpageTitle,
        isBack: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.data.userAvatarUrl),
              radius: 60,
            ),
            gapH12,
            Text('${widget.data.userName} '),
            _buildClickableText(widget.data.userLink, () {
              launchUrl(Uri.parse(widget.data.userLink));
            }),
            const SizedBox(
              height: 10,
              width: double.infinity,
            ),
            const SizedBox(height: 10),
            _customContainer(widget.data, plainText, isLoading),
          ],
        ),
      ),
    );
  }
}

Widget _buildClickableText(String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

Widget _customContainer(
    GithubRepoModel data, String decodeddata, bool isLoading) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey[200],
      boxShadow: [
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-4, -4),
          blurRadius: 6,
        ),
        BoxShadow(
          color: Colors.grey[500]!,
          offset: const Offset(4, 4),
          blurRadius: 6,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.repoName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildClickableText(data.repoLink, () {
          launchUrl(Uri.parse(data.repoLink));
        }),
        const SizedBox(height: 8),
        Text(
          'open issue: ${data.openIssuesCount}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'default branch:${data.defaultBranch} ',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Readme content',
          style: TextStyle(fontSize: 16),
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                decodeddata,
                style: const TextStyle(fontSize: 16),
              ),
      ],
    ),
  );
}
