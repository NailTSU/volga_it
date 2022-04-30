import 'package:flutter/material.dart';
import 'package:volga_it/components/company_info.dart';
import 'package:volga_it/components/root_wrapper.dart';
import 'package:volga_it/models/company_view_args.dart';

class CompanyView extends StatelessWidget {
  const CompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompanyViewArgs args = ModalRoute.of(context)!.settings.arguments as CompanyViewArgs;

    return RootWrapper(
      title: args.name,
      body: CompanyInfoContainer(symbol: args.symbol),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add, size: 32),
          onPressed: () {

          }),
    );
  }

}