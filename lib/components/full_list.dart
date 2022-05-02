import 'package:flutter/material.dart';
import 'package:volga_it/models/company_base.dart';
import 'package:volga_it/services/favourite_service.dart';

class FullList extends StatefulWidget {
  const FullList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FullListState();
  }

}

class _FullListState extends State<FullList> {
  late FavouriteService _favouriteService;
  late Future<List<CompanyBase>> _companiesList;

  _FullListState() {
    _favouriteService = FavouriteService();
  }

  @override
  void initState() {
    super.initState();
    _companiesList = _favouriteService.getItemsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _companiesList,
        builder: (BuildContext context, AsyncSnapshot<List<CompanyBase>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data?[index];
                return Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(color: Colors.white, width: 1))),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        data?.description ?? '',
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.white),
                      )),
                );
              }
            );
          }

          if (snapshot.hasError) {
            return const Text('error');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

}