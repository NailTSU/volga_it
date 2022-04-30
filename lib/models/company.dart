class Company {
  String description;
  String displaySymbol;
  String symbol;
  String type;

  Company({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
    required this.type
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        description: json["description"],
        displaySymbol: json["displaySymbol"],
        symbol: json["symbol"],
        type: json["type"]
    );
  }
}