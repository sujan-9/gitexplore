import 'package:flutter_riverpod/flutter_riverpod.dart';

final perPageProvider = StateProvider<int>((
  ref,
) {
  return 10;
});

final currentPageProvider = StateProvider<int>((
  ref,
) {
  return 1;
});

final sortProvider = StateProvider<String?>((
  ref,
) {
  return 'stars';
});
