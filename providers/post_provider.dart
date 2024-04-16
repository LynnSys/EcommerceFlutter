import 'package:flutter/cupertino.dart';
import 'package:shopping/api_service/ApiService.dart';
import 'package:shopping/model/post.dart';
import 'package:flutter/foundation.dart';

class PostProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  List<Post> _postData = [];

  List<Post> postData = [];

  List<Post> _products = [];
  final List<Post> _cartItems = [];
  late List<Post> _allProducts = [];

  List<Post> get products => _products;
  List<Post> get cartItems => _cartItems;

  loadData() async {
      print("Clicked");
      postData= [];
      var result = await apiService.getPosts();
      _postData = result;
      postData = _postData;
      // _allProducts= List.from(postData);
      // print(result);
      notifyListeners();
    }

  // calculate total price
  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += (item.price ?? 0) * item.quantity;
    }
    return total;
  }

  // searchData(String searchText) {
  //   if (searchText.isEmpty) {
  //     postData = _postData;
  //   } else {
  //     final searchData = _postData
  //         .where((element) =>
  //     (element.title ?? '').contains(searchText) ||
  //         (element.description ?? '').contains(searchText))
  //         .toList();
  //     postData = searchData;
  //   }
  //   notifyListeners();
  // }
  // void searchData(String searchText) {
  //   if (searchText.isEmpty) {
  //     _products = _allProducts;
  //   } else {
  //     _products = _allProducts.where((product) =>
  //     product.title?.toLowerCase().contains(searchText.toLowerCase()) ?? false).toList();
  //   }
  //   notifyListeners();
  // }

  void addToCart(Post product) {
    bool isInCart = _cartItems.contains(product);
    if (!isInCart) {
      product.quantity = 1;
    }
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Post product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void incrementQuantity(Post product) {
    product.incrementQuantity();
    notifyListeners();
  }

  void decrementQuantity(BuildContext context, Post product) {
    product.decrementQuantity(context);
    if (product.quantity == 0) {
      removeFromCart(product);
    }
    notifyListeners();
  }

  searchData(String searchText) {
    if (searchText.isEmpty) {
      postData = _postData;
    } else {
      final searchData = _postData
          .where((element) =>
      (element.title?.toLowerCase() ?? '').contains(searchText.toLowerCase()) ||
          (element.description?.toLowerCase() ?? '').contains(searchText.toLowerCase()))
          .toList();
      postData = searchData;
    }
    notifyListeners();
  }
}
