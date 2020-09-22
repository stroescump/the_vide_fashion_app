class Product {
  String name;
  double price;
  String currency;
  String description;
  String availableColors;
  String availableSizes;
  String imgUrl;

  Product(name, price, description, imgUrl) {
    this.name = name;
    this.price = price;
    this.description = description;
    this.imgUrl = imgUrl;
  }
}
