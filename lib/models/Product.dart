class Product {
  String name;
  double price;
  String currency;
  String description;
  String availableColors;
  String availableSizes;
  List<String> imgUrl;

  Product(name, price, description, imgUrl, currency) {
    this.name = name;
    this.price = price;
    this.description = description;
    this.imgUrl = imgUrl;
    this.currency = currency;
  }
}
