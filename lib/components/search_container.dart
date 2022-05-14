import 'package:flutter/material.dart';
import 'package:volga_it/components/bottom_navigator.dart';
import 'package:volga_it/constants/routes.dart';
import 'package:volga_it/models/company.dart';
import 'package:volga_it/models/company_view_args.dart';
import 'package:volga_it/services/search_api_service.dart';

class SearchContainer extends StatefulWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  _SearchContainerState createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  late SearchApiService _searchApiService;
  late TextEditingController _searchQuery;

  Future<List<Company>>? _futureList;

  _SearchContainerState() {
    _searchApiService = SearchApiService();
    _searchQuery = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: _buildSearchField(),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
        child: FutureBuilder<List<Company>>(
          future: _futureList,
          builder: (context, AsyncSnapshot<List<Company>> snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data ?? [];

              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    var item = list[index];

                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 1))),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.company,
                                arguments: CompanyViewArgs(
                                    name: item.description,
                                    symbol: item.symbol));
                          },
                          child: Text(
                            item.description + ' / ' + item.symbol,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.white),
                          )),
                    );
                  });
            }

            if (snapshot.hasError) {
              return const Text("Error");
            }

            return Container();
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigator(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Поиск...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: _onInputChange,
    );
  }

  void _onInputChange(String value) {
    setState(() {
      _futureList = _searchApiService.getCompaniesList(value);
    });
  }
}
