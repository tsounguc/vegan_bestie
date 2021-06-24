class ProductInfo {
  String? error;
  String? barcode;
  String? imageUrl;
  String? productName;
  String? ingredients;
  String? labels;
  bool loading;


  ProductInfo({
    this.barcode = "",
    this.imageUrl = "",
    this.productName = "",
    this.ingredients = "",
    this.labels = "",
    this.error  = "",
    this.loading = false,
  });
}
