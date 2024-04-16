import 'package:flutter/cupertino.dart';

class Post {
  // int? id;
  String? title;
  String? brand;
  String? description;
  double? rating;
  int? price;
  // double? price;
  List<dynamic> image;
  int quantity;

  Post(
      {this.description,
      this.title,
      // this.id,
        this.brand,
      required this.image,
      required this.rating,
      this.price,
        this.quantity = 1
      });

  void incrementQuantity() {
    quantity++;
  }

  int getItemPrice() {
    return (price ?? 0) * quantity;
  }

  void decrementQuantity(BuildContext context) {
    if (quantity > 0) {
      quantity--;
    }
  }

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
        //id:map["id"] as int,
        description: map["description"] as String,
        title: map["brand"] as String,
        brand: map["title"] as String,
        image: map["images"] as List<dynamic>,
        rating: map["rating"] is int ? (map["rating"] as int).toDouble() : map["rating"] as double?,
        price: map["price"] as int?,
        //price: map["price"] is int ? (map["rating"] as int).toDouble() : map["rating"] as double?,
        );
  }
}
