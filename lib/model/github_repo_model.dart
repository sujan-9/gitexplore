class GithubApiModel {
  final int totalCount;
  final List<GithubRepoModel> items;

  GithubApiModel({required this.totalCount, required this.items});

  factory GithubApiModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> items = json['items'];
    return GithubApiModel(
      totalCount: json['total_count'],
      items: items.map((item) => GithubRepoModel.fromJson(item)).toList(),
    );
  }
}

class GithubRepoModel {
  final String repoName;
  final String userName;
  final String userAvatarUrl;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final int openIssuesCount;
  final String defaultBranch;
  final String description;
  final DateTime updatedAt;
  final String repoLink;
  final String userLink;

  GithubRepoModel({
    required this.repoName,
    required this.userName,
    required this.userAvatarUrl,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.defaultBranch,
    required this.description,
    required this.updatedAt,
    required this.repoLink,
    required this.userLink,
  });

  factory GithubRepoModel.fromJson(Map<String, dynamic> json) {
    return GithubRepoModel(
      repoName: json['name'],
      userName: json['owner']['login'],
      userAvatarUrl: json['owner']['avatar_url'],
      userLink: json['owner']['html_url'],
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      forksCount: json['forks_count'],
      openIssuesCount: json['open_issues_count'],
      defaultBranch: json['default_branch'],
      description: json['description'],
      updatedAt: DateTime.parse(json['updated_at']),
      repoLink: json['html_url'],
    );
  }
}
