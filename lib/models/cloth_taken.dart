class ClothTaken {
  final String cloth;
  final int qty;
  final double rate;

  ClothTaken({
    required this.cloth,
    required this.qty,
    required this.rate,
  });

  factory ClothTaken.fromMap(Map<String, dynamic> clothData) {
    return ClothTaken(
      cloth: clothData['cloth'] ?? '',
      qty: clothData['qty'] ?? 0,
      rate: clothData['rate']?.toDouble() ?? 0.0,
    );
  }
}
