class ProductInfo {
  String? error;
  String? barcode;
  String? imageUrl;
  String? imageToUpLoadPath;
  String? productName;
  String? ingredients;
  String? labels;

  bool loading;


  ProductInfo({
    this.barcode = "",
    this.imageUrl = "",
    this.imageToUpLoadPath = "",
    this.productName = "",
    this.ingredients = "",
    this.labels = "",
    this.error  = "",
    this.loading = false,
  });
}
