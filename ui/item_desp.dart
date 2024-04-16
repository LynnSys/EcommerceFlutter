// import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../model/post.dart';
// import '../providers/post_provider.dart';
// import 'cart_page.dart';
//
// class DescriptionPage extends StatefulWidget {
//   final Post product;
//
//   const DescriptionPage({super.key, required this.product});
//
//   @override
//   State<DescriptionPage> createState() => _DescriptionPageState();
// }
//
// class _DescriptionPageState extends State<DescriptionPage> {
//   late CarouselController _carouselController;
//
//   @override
//   void initState() {
//     super.initState();
//     _carouselController = CarouselController();
//   }
//
//   Widget _buildRatingStars(double rating) {
//     int numberOfStars = rating.floor();
//     List<Widget> stars = [];
//     for (int i = 0; i < numberOfStars; i++) {
//       stars.add(const Icon(Icons.star, color: Colors.yellow));
//     }
//     if (rating - numberOfStars > 0.5) {
//       stars.add(const Icon(Icons.star_half, color: Colors.yellow));
//     }
//     return Row(
//       children: stars,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade100,
//       appBar: AppBar(
//         title: Text(
//           widget.product.title ?? '',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xff1f1c2c), Color(0xff928dab)],
//             stops: [0, 1],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 CarouselSlider.builder(
//                   carouselController: _carouselController,
//                   itemCount: widget.product.image.length,
//                   options: CarouselOptions(
//                     height: 250,
//                     viewportFraction: 0.8,
//                     autoPlay: true,
//                     autoPlayInterval: const Duration(seconds: 3),
//                   ),
//                   itemBuilder: (context, index, realIndex) {
//                     return Image.network(
//                       widget.product.image[index] ?? '',
//                       fit: BoxFit.contain,
//                     );
//                   },
//                 ),
//                 Positioned(
//                   left: 16,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         _carouselController.previousPage();
//                       },
//                       icon: const Icon(Icons.arrow_back, color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 16,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         _carouselController.nextPage();
//                       },
//                       icon: const Icon(
//                           Icons.arrow_forward, color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${widget.product.price ?? ''}',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     'Price: ₹${widget.product.price ?? ''}',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   _buildRatingStars(widget.product.rating ?? 0),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Description:\n ${widget.product.description ?? ''}',
//                     style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 16),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           bool isInCart = Provider
//                               .of<PostProvider>(context, listen: false)
//                               .cartItems
//                               .contains(widget.product);
//                           if (isInCart) {
//                             Provider.of<PostProvider>(context, listen: false)
//                                 .incrementQuantity(widget.product);
//                           } else {
//                             Provider.of<PostProvider>(context, listen: false)
//                                 .addToCart(widget.product);
//                           }
//                           Navigator.push(context, MaterialPageRoute(
//                               builder: (context) => const CartPage()),
//                           );
//                         },
//                         child: const Text('Add to Cart', style: TextStyle(
//                             fontSize: 16),),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/post.dart';
import '../providers/post_provider.dart';
import 'cart_page.dart';

class DescriptionPage extends StatefulWidget {
  final Post product;

  const DescriptionPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  Widget _buildRatingStars(double rating) {
    int numberOfStars = rating.floor();
    List<Widget> stars = [];
    for (int i = 0; i < numberOfStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.yellow));
    }
    if (rating - numberOfStars > 0.5) {
      stars.add(const Icon(Icons.star_half, color: Colors.yellow));
    }
    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1f1c2c), Color(0xff928dab)],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Container(
              height: 250, // Adjust height as needed
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: widget.product.image.length,
                options: CarouselOptions(
                  aspectRatio: 1.0, // Ensure aspect ratio remains 1:1 for uniform images
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 1),
                ),
                itemBuilder: (context, index, realIndex) {
                  return Container(
                      decoration: const BoxDecoration(
                        color:Color(0xff1C2541),
                      ),
                      child: Image.network(
                    widget.product.image[index] ?? '',
                    fit: BoxFit.contain, // Use BoxFit.cover for uniform images
                  ),
                  );
                },
              ),
            ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand: ${widget.product.brand ?? ''}',
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: ₹${widget.product.price ?? ''}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white),
                  ),
                  const SizedBox(height: 8),
                    _buildRatingStars(widget.product.rating ?? 0),
                  const SizedBox(height: 8),
                  Text(
                  'Description:\n ${widget.product.description ?? ''}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white),
                  ),
                  const SizedBox(height: 16),
              ]
              ),
          ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quantity: ${widget.product.quantity}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           if (_quantity > 1) {
                  //             _quantity--;
                  //           }
                  //         });
                  //       },
                  //       icon: const Icon(Icons.remove),
                  //     ),
                  //     const SizedBox(width: 16),
                  //     IconButton(
                  //         onPressed: () {
                  //           widget.product.incrementQuantity();
                  //         },
                  //         icon: const Icon(Icons.add)
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                bool isInCart = Provider.of<PostProvider>(context, listen: false)
                    .cartItems
                    .contains(widget.product);
                if (isInCart) {
                  Provider.of<PostProvider>(context, listen: false)
                      .incrementQuantity(widget.product);
                } else {
                  Provider.of<PostProvider>(context, listen: false)
                      .addToCart(widget.product);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              child: Container(
                color: const Color(0xff1C2541),
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white),
                    SizedBox(width: 16),
                    Text('Add to Cart', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),

        ])
      )
    );
  }
}
