class BitcoinPrice {
  final double usd;

  BitcoinPrice({required this.usd});

  factory BitcoinPrice.fromJson(Map<String, dynamic> json) {
    return BitcoinPrice(
      usd: json['bitcoin']['usd'].toDouble(),
    );
  }
}
