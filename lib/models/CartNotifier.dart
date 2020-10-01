import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:the_vide/models/ProductCart.dart';

class CartNotifier extends ChangeNotifier {
  final List<ProductCart> _productsInCart = [];

  UnmodifiableListView<ProductCart> get getItemsFromCart =>
      UnmodifiableListView(_productsInCart);

  void removeAllProductsFromCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  void addItemToCart(ProductCart productToBeAdded) {
    _productsInCart.add(productToBeAdded);
    notifyListeners();
  }

  void removeItem(ProductCart productToBeRemoved) {
    _productsInCart.remove(productToBeRemoved);
    notifyListeners();
  }
}
