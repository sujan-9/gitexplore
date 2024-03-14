import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:githubexplore/controller/github_api/api_services.dart';
import 'package:githubexplore/model/github_repo_model.dart';

@immutable
abstract class PostState {}

class InitialState extends PostState {}

class LoadingState extends PostState {}

class LoadedState extends PostState {
  final GithubApiModel apiData;

  LoadedState({required this.apiData});
}

class ErrorState extends PostState {
  final String error;

  ErrorState({required this.error});
}

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier({required this.apiservice}) : super(InitialState());
  final ApiService apiservice;

  fetchData({
    required String query,
    required String sort,
    required int perPage,
    required int currentPage,
  }) async {
    try {
      state = LoadingState();
      GithubApiModel apiData =
          await apiservice.getData(query, sort, perPage, currentPage);
      if (apiData.items.isNotEmpty) {
        state = LoadedState(apiData: apiData);
      }
    } catch (e) {
      state = ErrorState(error: e.toString());
    }
  }

  fetchMoreData({
    required String query,
    required String sort,
    required int perPage,
    required int currentPage,
  }) async {
    try {
      if (state is LoadedState) {
        state = LoadingState();
        GithubApiModel morePosts = await apiservice.getData(
          query,
          sort,
          perPage,
          currentPage,
        );
        if (morePosts.items.isNotEmpty) {
          GithubApiModel updatedPosts = GithubApiModel(
            totalCount: (state as LoadedState).apiData.totalCount,
            items: [
              ...(state as LoadedState).apiData.items,
              ...morePosts.items
            ],
          );
          state = LoadedState(apiData: updatedPosts);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
