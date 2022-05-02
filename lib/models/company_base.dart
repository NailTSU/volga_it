class CompanyBase {
  String description;
  String symbol;

  CompanyBase({
    required this.description,
    required this.symbol
  });

  Map toJson() => {
    "description": description,
    "symbol": symbol
  };

  factory CompanyBase.fromJson(Map<String, dynamic> json) {
    return CompanyBase(
        description: json["description"],
        symbol: json["symbol"]
    );
  }
}