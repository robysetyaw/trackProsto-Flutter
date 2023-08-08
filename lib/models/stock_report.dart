class StockReport {
  final String meatId;
  final String meatName;
  final int totalStockIn;
  final int totalStockOut;
  final int stockMovement;
  final int totalStock;

  StockReport({
    required this.meatId,
    required this.meatName,
    required this.totalStockIn,
    required this.totalStockOut,
    required this.stockMovement,
    required this.totalStock,
  });

  factory StockReport.fromJson(Map<String, dynamic> json) {
    return StockReport(
      meatId: json['meat_id'],
      meatName: json['meat_name'],
      totalStockIn: json['total_stock_in'],
      totalStockOut: json['total_stock_out'],
      stockMovement: json['stock_movement'],
      totalStock: json['total_stock'],
    );
  }

}
