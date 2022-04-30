import 'dart:developer';

class CompanyInfo {
  String country;
  String currency;
  double marketCapitalization;
  String name;
  String weburl;
  String logo;
  String finnhubIndustry;
  String? quotePrice;

  CompanyInfo({
    required this.country,
    required this.currency,
    required this.marketCapitalization,
    required this.name,
    required this.weburl,
    required this.logo,
    required this.finnhubIndustry
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
        country: json["country"],
        currency: json["currency"],
        marketCapitalization: json["marketCapitalization"],
        name: json["name"],
        weburl: json["weburl"],
        logo: json["logo"],
        finnhubIndustry: json["finnhubIndustry"],
    );
  }
}