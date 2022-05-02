import 'package:flutter/material.dart';
import 'package:volga_it/models/company_info.dart';

class CompanyInfoContainer extends StatelessWidget {
  final bool isLoading;
  final Future<CompanyInfo> futureData;

  const CompanyInfoContainer({
    Key? key,
    required this.futureData,
    this.isLoading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData && !isLoading) {
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
