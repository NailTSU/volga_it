class PriceHistory {
  final List<double>? c;

  PriceHistory({ this.c });

  factory PriceHistory.fromJson(Map<String, dynamic> json) {
    return PriceHistory(
      c: json["c"]?.toDouble()
    );
  }
}