import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:volga_it/components/company_info.dart';
import 'package:volga_it/components/root_wrapper.dart';
import 'package:volga_it/constants/routes.dart';
import 'package:volga_it/models/company_base.dart';
import 'package:volga_it/models/company_info.dart';
import 'package:volga_it/models/company_view_args.dart';
import 'package:volga_it/services/company_api_service.dart';
import 'package:volga_it/services/favourite_service.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({Key? key}): super(key: key);

  @override
  _CompanyViewState createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  late CompanyApiService _apiService;
  late Future<CompanyInfo> _companyData;
  late FavouriteService _favouriteService;
  late Future<List<CompanyBase>> _companiesList;

  CompanyViewArgs? _args;
  bool _isLoading = false;
  bool _isHomeView = false;

  _CompanyViewState() {
    _apiService = CompanyApiService();
    _favouriteService = FavouriteService();
  }

  @override
  void initState() {
    super.initState();
    _companiesList = _favouriteService.getItemsList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var routeContext = ModalRoute.of(context);

    if (routeContext!.settings.name == Routes.root) {
      setState(() {
        _isHomeView = true;
      });
      onLoad();
    } else {
      setState(() {
        _isHomeView = false;
        _args = routeContext.settings.arguments as CompanyViewArgs;
      });
      _companyData = _apiService.getCompanyBySymbol(_args?.symbol ?? '');
    }
  }

  void onLoad() async {
    var list = await _favouriteService.getItemsList();
    setState(() {
      _args = CompanyViewArgs(name: list[0].description, symbol: list[0].symbol);
    });
    _companyData = _apiService.getCompanyBySymbol(list[0].symbol);
  }

  Future<void> _onFloatingButtonPress(CompanyViewArgs args, bool isToDelete) async {
    setState(() {
      _isLoading = true;
    });

    var item = CompanyBase(description: args.name, symbol: args.symbol);

    if (isToDelete) {
      await _favouriteService.deleteItem(item);
    } else {
      await _favouriteService.addItem(item);
    }

    _companiesList = _favouriteService.getItemsList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_args?.symbol == null) {
      return RootWrapper(
        title: '',
        body: Container(),
      );
    }

    return RootWrapper(
      title: _isHomeView ? 'Последнее' : _args?.name ?? '',
      body: CompanyInfoContainer(futureData: _companyData, isLoading: _isLoading),
      floatingActionButton: _isHomeView ? Container() : FutureBuilder(
        future: _companiesList,
        builder: (BuildContext context, AsyncSnapshot<List<CompanyBase>> snapshot) {
          if (snapshot.hasData) {
            bool isToDelete = snapshot.data?.any((element) => _args?.symbol == element.symbol) ?? false;

            return FloatingActionButton(
                backgroundColor: isToDelete ? Colors.redAccent : Colors.amber,
                child: Icon(isToDelete ? Icons.delete : Icons.add, size: 32),
                onPressed: () {
                  _onFloatingButtonPress(_args!, isToDelete);
                });
          }

          return Container();
        },
      ),
    );
  }

}