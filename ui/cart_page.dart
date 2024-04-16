// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopping/model/post.dart';
// import 'package:shopping/providers/post_provider.dart';
//
// import '../HomePage/HomePage.dart';
//
//
// class CartPage extends StatelessWidget {
//   const CartPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var cartData = Provider.of<PostProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title:  Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(top: 11),
//                 child: Text('MY CART',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//               ),
//               IconButton(onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const HomePage(),
//                   ),
//                 );
//               }, icon:const Icon(Icons.home , color: Colors.white, size: 30,)
//               )
//
//             ]
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: ListView.builder(
//         itemCount: cartData.cartItems.length,
//         itemBuilder: (context, index) {
//           var product = cartData.cartItems[index];
//           if()
//           return Card(
//             margin: const EdgeInsets.only(top:7, left:7, bottom:7, right:2),
//             child: ListTile(
//               leading: Image.network(
//                 product.image[0] ?? '',
//                 width: 80,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(product.title ?? '', style: const TextStyle (fontWeight: FontWeight.bold,)),
//               subtitle:Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Price: ₹ ${product.price ?? ''}'),
//                   Text('Total Price: ₹ ${product.getTotalPrice()}', ),
//                 ],
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       cartData.decrementQuantity(context, product);
//                     },
//                     icon: Icon(Icons.remove),
//                   ),
//                   Text('${product.quantity}'),
//
//                   IconButton(
//                     onPressed: () {
//                       cartData.incrementQuantity(product);
//                     },
//                     icon: Icon(Icons.add),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       cartData.removeFromCart(product);
//                     },
//                     icon: Icon(Icons.delete),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16),
//         color: Colors.grey[200],
//         child: Text(
//           'Total Price: ₹ ${cartData.totalPrice}',
//           textAlign: TextAlign.right,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/post_provider.dart';

import '../HomePage/HomePage.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 11),
              child: Text(
                'My Cart',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              icon: const Icon(Icons.home, color: Colors.white, size: 30),
            ),
          ],
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
        child: Consumer<PostProvider>(
          builder: (context, cartData, child) => cartData.cartItems.isEmpty
              ? const Center(
            child: ListTile(
              title: Text(
                'Your cart is Empty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
              : ListView.builder(
            itemCount: cartData.cartItems.length,
            itemBuilder: (context, index) {
              var product = cartData.cartItems[index];
              return Dismissible(
                key: Key(index.toString()), // Use product id as the key
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  cartData.removeFromCart(product);
                },
                child: Card(
                  margin: const EdgeInsets.all(7),
                  child: ListTile(
                    leading: Image.network(
                      product.image[0] ?? '',
                      width: 90,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Price: ₹ ${product.price ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                        ),

                        Text(
                          'Total Price: ₹ ${product.getItemPrice()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            cartData.decrementQuantity(context, product);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '${product.quantity}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            cartData.incrementQuantity(product);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Consumer<PostProvider>(
          builder: (context, cartData, child) => Text(
            'Total Price: ₹ ${cartData.totalPrice}',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopping/providers/post_provider.dart';
//
// import '../HomePage/HomePage.dart';
//
// class CartPage extends StatelessWidget {
//   const CartPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var cartData = Provider.of<PostProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 11),
//               child: Text(
//                 'My Cart',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const HomePage(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.home, color: Colors.white, size: 30),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),
//       body: cartData.cartItems.isEmpty
//           ? const ListTile(
//               title: Text(
//                 'Your cart is Empty',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )
//           : ListView.builder(
//               itemCount: cartData.cartItems.length,
//               itemBuilder: (context, index) {
//                 var product = cartData.cartItems[index];
//                 return Dismissible(
//                   key: Key(index.toString()),
//                   direction: DismissDirection.endToStart,
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 16),
//                     child: const Icon(
//                       Icons.delete,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onDismissed: (direction) {
//                     cartData.removeFromCart(product);
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.only(
//                         top: 7, left: 7, bottom: 7, right: 7),
//                     child: ListTile(
//                       leading: Image.network(
//                         product.image[0] ?? '',
//                         width: 80,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                       title: Text(
//                         '${product.title} ${product.title}' ?? '',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Price: ₹ ${product.price ?? ''}'),
//                           Text('Total Price: ₹ ${product.getTotalPrice()}'),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               cartData.decrementQuantity(context, product);
//                             },
//                             icon: const Icon(Icons.remove),
//                           ),
//                           Text('${product.quantity}'),
//                           IconButton(
//                             onPressed: () {
//                               cartData.incrementQuantity(product);
//                             },
//                             icon: const Icon(Icons.add),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         color: Colors.grey[200],
//         child: Text(
//           'Total Price: ₹ ${cartData.totalPrice}',
//           textAlign: TextAlign.right,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }
