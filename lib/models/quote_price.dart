class QuotePrice {
  double? c;
  double? d;
  double? dp;
  double? h;
  double? l;
  double? o;
  double? pc;
  int? t;

  QuotePrice({
    this.c, this.d, this.dp, this.h, this.l, this.o, this.pc, this.t
  });

  factory QuotePrice.fromJson(Map<String, dynamic> json) {
    return QuotePrice(
      c: json["c"]?.toDouble(),
      d: json["d"]?.toDouble(),
      dp: json["dp"]?.toDouble(),
      h: json["h"]?.toDouble(),
      l: json["l"]?.toDouble(),
      o: json["o"]?.toDouble(),
      pc: json["pc"]?.toDouble(),
      t: json["t"],
    );
  }
}
