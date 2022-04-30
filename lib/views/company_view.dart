import 'package:flutter/material.dart';
import 'package:volga_it/components/company_info.dart';
import 'package:volga_it/components/root_wrapper.dart';
import 'package:volga_it/models/company_view_args.dart';
import 'package:volga_it/services/favourite_service.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({Key? key}): super(key: key);

  @override
  _CompanyViewState createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  late FavouriteService _favouriteService;
  late Future<List<String>> _companiesList;
  bool _isLoading = false;

  _CompanyViewState() {
    _favouriteService = FavouriteService();
  }

  @override
  void initState() {
    super.initState();
    _companiesList = _favouriteService.getItemsList();
  }

  Future<void> _onFloatingButtonPress(String symbol, bool isToDelete) async {
    setState(() {
      _isLoading = true;
    });

    if (isToDelete) {
      await _favouriteService.deleteItem(symbol);
    } else {
      await _favouriteService.addItem(symbol);
    }

    _companiesList = _favouriteService.getItemsList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CompanyViewArgs args = ModalRoute.of(context)!.settings.arguments as CompanyViewArgs;

    return RootWrapper(
      title: args.name,
      body: CompanyInfoContainer(symbol: args.symbol, isLoading: _isLoading),
      floatingActionButton: FutureBuilder(
        future: _companiesList,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            bool isToDelete = snapshot.data?.contains(args.symbol) ?? false;

            return FloatingActionButton(
                backgroundColor: isToDelete ? Colors.redAccent : Colors.amber,
                child: Icon(isToDelete ? Icons.delete : Icons.add, size: 32),
                onPressed: () {
                  _onFloatingButtonPress(args.symbol, isToDelete);
                });
          }

          return Container();
        },
      ),
    );
  }

}