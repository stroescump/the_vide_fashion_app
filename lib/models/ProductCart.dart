import 'package:the_vide/models/Product.dart';

class ProductCart {
  String sizeOfProduct;
  Product product;
  int quantity;

  ProductCart(this.product, this.quantity, this.sizeOfProduct);

  @override
  String toString() {
    return 'ProductCart{sizeOfProduct: $sizeOfProduct, product: $product, quantity: $quantity}';
  }
}
