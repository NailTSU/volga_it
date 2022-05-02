import 'package:flutter/material.dart';
import 'package:volga_it/views/company_view.dart';
import 'package:volga_it/views/full_list_view.dart';
import 'package:volga_it/views/home_view.dart';
import 'package:volga_it/views/search_view.dart';

import 'constants/routes.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Акции',
      initialRoute: Routes.root,
      routes: {
        Routes.root: (context) => const HomeView(),
        Routes.list: (context) => const FullListView(),
        Routes.search: (context) => const SearchView(),
        Routes.company: (context) => const CompanyView(),
      },
    );
  }

}
