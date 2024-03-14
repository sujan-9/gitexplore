import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:githubexplore/app/utils/constants/error_handler.dart';
import 'package:githubexplore/app/utils/constants/http_response_message.dart';
import 'package:githubexplore/app/utils/constants/http_responsecode.dart';
import 'package:githubexplore/controller/github_api/api_state_provider.dart';
import 'package:githubexplore/presentation/provider/provider.dart';
import 'package:githubexplore/presentation/utils/show_toast.dart';

void fetch(WidgetRef ref, int perpage, TextEditingController controller,
    String sort) async {
  try {
    await ref.read(stateProvider.notifier).fetchData(
          query: controller.text.trim(),
          sort: sort,
          perPage: ref.watch(perPageProvider),
          currentPage: ref.watch(currentPageProvider),
        );
  } catch (e) {
    final errorHandler = ErrorHandler.handle(e);

    switch (errorHandler.failure.code) {
      case ResponseCode.badRequest:
        showToast(ResponseMessage.badRequest);

        break;
      case ResponseCode.unauthorized:
        showToast(ResponseMessage.unauthorized);
        break;
      case ResponseCode.forbidden:
        showToast(ResponseMessage.forbidden);
        break;
      case ResponseCode.notFound:
        showToast(ResponseMessage.notFound);
        break;
      case ResponseCode.internalServerError:
        showToast(ResponseMessage.internalServerError);
        break;
      case ResponseCode.connectTimeOut:
        showToast(ResponseMessage.connectTimeOut);
        break;
      case ResponseCode.notProcessable:
        showToast(ResponseMessage.notProcessable);
        break;

      default:
        showToast(ResponseMessage.defaultError);
        break;
    }
  }
}
