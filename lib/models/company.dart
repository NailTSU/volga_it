import 'package:volga_it/models/company_base.dart';

class Company extends CompanyBase {
  String displaySymbol;
  String type;

  Company({
    required this.displaySymbol,
    required this.type,
    description,
    symbol
  }) : super(description: description, symbol: symbol);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        description: json["description"],
        displaySymbol: json["displaySymbol"],
        symbol: json["symbol"],
        type: json["type"]
    );
  }
}