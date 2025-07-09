import 'package:flutter/material.dart';
import '../models/product.dart';

// Ubah jadi public biar bisa diakses di file lain
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void increaseQty(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  void decreaseQty(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
