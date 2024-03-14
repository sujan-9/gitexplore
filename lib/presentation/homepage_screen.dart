import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_loader.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_text.dart';
import 'package:githubexplore/app/utils/helper/check_network.dart';
import 'package:githubexplore/app/utils/helper/formate_date.dart';
import 'package:githubexplore/controller/github_api/api_data_state.dart';
import 'package:githubexplore/controller/github_api/api_state_provider.dart';
import 'package:githubexplore/app/config/routes/path_root.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_appbar.dart';
import 'package:githubexplore/app/utils/constants/app_strings.dart';
import 'package:githubexplore/app/utils/constants/asset_provider.dart';
import 'package:githubexplore/app/utils/constants/pallets.dart';
import 'package:githubexplore/app/utils/constants/sizes.dart';
import 'package:githubexplore/presentation/provider/provider.dart';
import 'package:githubexplore/presentation/utils/fetch_data.dart';
import 'package:githubexplore/presentation/utils/show_dialog.dart';
import 'package:githubexplore/presentation/utils/show_toast.dart';
import 'package:githubexplore/presentation/widgets/custom_button.dart';
import 'package:githubexplore/presentation/widgets/custom_textfiel.dart';
import 'package:go_router/go_router.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen>
    with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String sort = 'stars';

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<bool> didPopRoute() async {
    showBackDialog(context);
    return true;
  }

  bool pop = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var perpage = ref.watch(perPageProvider);
    var currentPage = ref.watch(currentPageProvider);
    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    // var isConnected = ref.read(isConnectedProvider);
    return PopScope(
      canPop: pop,
      onPopInvoked: (pop) {
        didPopRoute();
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: AppStrings.home),
        body: Padding(
          padding: const EdgeInsets.all(
            Sizes.p8,
          ),
          child: Column(
            children: [
              CustomTextField(
                controller: _controller,
                ref: ref,
              ),
              gapH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: ref.watch(sortProvider),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          sort = newValue;
                          ref.read(sortProvider.notifier).state = newValue;
                        }
                      },
                      items: <String>['stars', 'forks', 'updated']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  DropdownButton<int>(
                    value: perpage,
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        ref.read(perPageProvider.notifier).state = newValue;
                      }
                    },
                    items: <int>[10, 25, 50]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  ),
                  CustonButton(
                    text: CustomText.medium(AppStrings.search),
                    onPressed: () async {
                      if (_controller.text.isEmpty) {
                        showToast('Type to search');
                      }
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isDisonnected) {
                        showToast('No internet Connection');
                      }
                      if (_controller.text.isNotEmpty &&
                          connectivityStatusProvider ==
                              ConnectivityStatus.isConnected) {
                        fetch(
                            ref, ref.watch(perPageProvider), _controller, sort);
                      }
                    },
                  )
                ],
              ),
              gapH4,
              const Divider(
                thickness: 2,
              ),
              gapH8,
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  final state = ref.watch(stateProvider);

                  if (state is InitialState) {
                    return connectivityStatusProvider ==
                            ConnectivityStatus.isConnected
                        ? SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 300,
                                      child: Image.asset(AssetProvider.noData)),
                                  CustomText.medium(AppStrings.fetchData),
                                ]),
                          )
                        : _buildDisconnectedView('No internet connection');
                  }
                  if (state is LoadingState) {
                    return const Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  }

                  if (state is ErrorState) {
                    return _buildDisconnectedView(
                        '"Error occurred try again later"');
                  }

                  if (state is LoadedState) {
                    return Column(
                      children: [
                        Expanded(
                            child:
                                _listView(context, state, _scrollController)),
                        _buildRow(
                          currentPage: currentPage,
                          state: state,
                          perPage: perpage,
                          ref: ref,
                          fetch: () => fetch(ref, ref.watch(perPageProvider),
                              _controller, sort),
                        ),
                      ],
                    );
                  }
                  return const Text('No data');
                }),
              ),
              //_buildDisconnectedView(),
              gapH12,
            ],
          ),
        ),
      ),
    );
  }
}

Widget _listView(BuildContext context, LoadedState state,
    ScrollController scrollcontroller) {
  return ListView.builder(
    controller: scrollcontroller,
    itemCount: state.apiData.items.length,
    addAutomaticKeepAlives: true,
    //  reverse: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          GoRouter.of(context).pushNamed(Paths.detailPageScreenRoute.routeName,
              extra: state.apiData.items[index]);
        },
        child: _customContainer(state, index),
      );
    },
  );
}

Widget _customContainer(
  LoadedState state,
  int index,
) {
  var post = state.apiData.items[index];
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: whiteColor,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomText.medium(
                post.repoName,
              ),
            ),
          ],
        ),
        gapH8,
        CustomText.medium(post.userName),
        gapH8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              AssetProvider.startPath,
              height: 20,
              colorFilter: const ColorFilter.mode(redColor, BlendMode.srcIn),
              theme: const SvgTheme(currentColor: redColor),
            ),
            CustomText.small(post.stargazersCount.toString()),
            gapW16,
            Icon(Icons.visibility, color: Colors.blue.withOpacity(0.8)),
            CustomText.small(post.watchersCount.toString()),
            gapW16,
            SvgPicture.asset(
              AssetProvider.forkPath,
              height: 20,
              colorFilter: const ColorFilter.mode(redColor, BlendMode.srcIn),
            ),
            CustomText.small(post.forksCount.toString()),
          ],
        ),
        gapH12,
        Text(
          post.description,
          maxLines: 4,
          style: const TextStyle(
            fontSize: 15.0,
            fontFamily: 'Lato',
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        gapH8,
        CustomText.small(
          formatDate(post.updatedAt.toString()),
        )
      ],
    ),
  );
}

Widget _buildRow({
  required int currentPage,
  required LoadedState state,
  required int perPage,
  required WidgetRef ref,
  required VoidCallback fetch,
}) {
  int totalPage = (state.apiData.totalCount ~/ perPage) +
      ((state.apiData.totalCount % perPage) > 0 ? 1 : 0);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: currentPage > 1
            ? () {
                ref.read(currentPageProvider.notifier).state--;

                fetch();
              }
            : null,
      ),
      Text('Page $currentPage of $totalPage'),
      IconButton(
        icon: const Icon(Icons.arrow_forward),
        onPressed: currentPage < 10
            ? () {
                ref.read(currentPageProvider.notifier).state++;

                fetch();
              }
            : null,
      ),
    ],
  );
}

Widget _buildDisconnectedView(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        CustomText.medium(message),
        const SizedBox(height: 16),
      ],
    ),
  );
}
