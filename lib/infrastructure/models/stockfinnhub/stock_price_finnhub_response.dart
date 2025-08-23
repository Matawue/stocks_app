
class StockPriceFinnhubResponse {
    final double c;
    final double d;
    final double dp;
    final double h;
    final double l;
    final double o;
    final double pc;
    final int t;

    StockPriceFinnhubResponse({
        required this.c,
        required this.d,
        required this.dp,
        required this.h,
        required this.l,
        required this.o,
        required this.pc,
        required this.t,
    });

    factory StockPriceFinnhubResponse.fromJson(Map<String, dynamic> json) => StockPriceFinnhubResponse(
        c: json["c"]?.toDouble(),
        d: json["d"]?.toDouble(),
        dp: json["dp"]?.toDouble(),
        h: json["h"]?.toDouble(),
        l: json["l"]?.toDouble(),
        o: json["o"]?.toDouble(),
        pc: json["pc"]?.toDouble(),
        t: json["t"],
    );

    Map<String, dynamic> toJson() => {
        "c": c,
        "d": d,
        "dp": dp,
        "h": h,
        "l": l,
        "o": o,
        "pc": pc,
        "t": t,
    };
}
