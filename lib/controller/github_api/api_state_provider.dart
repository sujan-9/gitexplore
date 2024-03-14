import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:githubexplore/controller/github_api/api_data_state.dart';
import 'package:githubexplore/controller/github_api/api_services.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final stateProvider = StateNotifierProvider<PostNotifier, PostState>(
    (ref) => PostNotifier(apiservice: ref.watch(apiServiceProvider)));
