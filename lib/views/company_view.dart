import 'package:flutter/material.dart';
import 'package:volga_it/components/company_info.dart';
import 'package:volga_it/components/root_wrapper.dart';
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
  bool _isLoading = false;

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
    CompanyViewArgs args = ModalRoute.of(context)!.settings.arguments as CompanyViewArgs;
    _companyData = _apiService.getCompanyBySymbol(args.symbol);
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
    CompanyViewArgs args = ModalRoute.of(context)!.settings.arguments as CompanyViewArgs;

    return RootWrapper(
      title: args.name,
      body: CompanyInfoContainer(futureData: _companyData, isLoading: _isLoading),
      floatingActionButton: FutureBuilder(
        future: _companiesList,
        builder: (BuildContext context, AsyncSnapshot<List<CompanyBase>> snapshot) {
          if (snapshot.hasData) {
            bool isToDelete = snapshot.data?.any((element) => args.symbol == element.symbol) ?? false;

            return FloatingActionButton(
                backgroundColor: isToDelete ? Colors.redAccent : Colors.amber,
                child: Icon(isToDelete ? Icons.delete : Icons.add, size: 32),
                onPressed: () {
                  _onFloatingButtonPress(args, isToDelete);
                });
          }

          return Container();
        },
      ),
    );
  }

}