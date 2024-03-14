import 'dart:convert';
import 'package:githubexplore/model/github_repo_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<GithubApiModel> getData(
    String query,
    String sort,
    int perPage,
    int currentPage,
  ) async {
    String githubUrl =
        'https://api.github.com/search/repositories?q=$query&sort=$sort&per_page=$perPage&page=$currentPage';

    try {
      Uri url = Uri.parse(githubUrl);
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        return GithubApiModel.fromJson(responseData);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
