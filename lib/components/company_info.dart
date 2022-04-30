import 'package:flutter/material.dart';
import 'package:volga_it/models/company_info.dart';
import 'package:volga_it/services/company_api_service.dart';

class CompanyInfoContainer extends StatefulWidget {
  final String symbol;
  final bool isLoading;

  const CompanyInfoContainer({Key? key, required this.symbol, this.isLoading = false})
      : super(key: key);

  @override
  _CompanyInfoContainerState createState() => _CompanyInfoContainerState();
}

class _CompanyInfoContainerState extends State<CompanyInfoContainer> {
  late CompanyApiService _apiService;
  late Future<CompanyInfo> _futureData;

  _CompanyInfoContainerState() {
    _apiService = CompanyApiService();
  }

  @override
  void initState() {
    super.initState();
    _futureData = _apiService.getCompanyBySymbol(widget.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData && !widget.isLoading) {
            var data = snapshot.data as CompanyInfo;
            return Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Image(
                              image: NetworkImage(data.logo),
                              height: 48,
                              width: 48),
                        ),
                        Flexible(
                            child: Text(data.name,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24
                                ),
                                softWrap: true)
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        children: [
                          const Text('Капитализация: ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Text(
                              data.marketCapitalization.toString(),
                              style: const TextStyle(
                                  color: Colors.yellow, fontSize: 18))
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        children: [
                          const Text('Стоимость акций: ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Text(data.quotePrice ?? '',
                              style: const TextStyle(
                                  color: Colors.yellow, fontSize: 18))
                        ],
                      ),
                    )
                  ],
                ));
          }

          if (snapshot.hasError) {
            return Container();
          }

          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        });
  }
}
