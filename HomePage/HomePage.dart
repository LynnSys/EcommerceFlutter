import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/ui/cart_page.dart';

import '../api_service/ApiService.dart';
import '../model/post.dart';
import '../providers/post_provider.dart';
import '../ui/item_desp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  String data = "Loading";
  List<Post> postData = [];
  List<Post> _searchedProds = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    Provider.of<PostProvider>(context, listen: false).loadData();
  }
  // _loadData() async {
  //   setState(() {
  //     data = "Loading";
  //     postData = [];
  //   });
  //   print("Clicked");
  //   var result = await apiService.getPosts();
  //   print(result);
  //   setState(() {
  //     data = "";
  //     postData = result;
  //     _searchedProds=List.from(postData);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Consumer <PostProvider>(builder: (context, postProvider, _) {
      return Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1f1c2c), Color(0xff928dab)],
                stops: [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            //padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.sort,
                              size: 30,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartPage()),
                              );
                            },
                            child: Container(
                              // padding: const EdgeInsets.all(8),
                              child: const Badge(
                                backgroundColor: Colors.redAccent,
                                padding: EdgeInsets.all(5),
                                isLabelVisible: true,
                                label: Text(
                                  "3",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            onChanged: searchData,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search products"),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  _loadDataWidget(postProvider.postData)
                ],
              ),
            ),
          ),
      );
    });
  }

  _loadDataWidget(List<Post> postData) {
    if (postData.isEmpty) {
      return Center(
          child: Lottie.network(
              "https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json"));
    } else {
      return Expanded(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
            height: 50,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemCount: postData.length,
              itemBuilder: (context, index) {
                var post = postData[index];
                return InkWell(
                    onTap: () {
                      _goToPostView(postData[index], index);
                    },
                    child: Card(
                        shadowColor: Colors.black,
                        color: Colors.grey.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          // Add padding here
                          child: Column(children: [
                            const SizedBox(height: 10),
                            Expanded(
                              child: Image.network(
                                post.image[0] ?? "",
                                width: 120,
                                height: 100,
                              ),
                            ),
                            Center(
                              child: Text(post.title ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            Center(
                              child: Text(post.brand ?? '',
                                  textAlign: TextAlign.center),
                            ),
                            Text('Rs.${post.price}' ?? ""),
                          ]),
                        )));
              },
            )),
      ));
    }
  }

  _goToPostView(Post postModel, int index) async {
    print("Post index: $index , Title: ${postModel.title ?? ''}");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("title", postModel.title ?? '');
    await preferences.setString("desc", postModel.description ?? '');
    // List<String> imageStrings = postModel.image.map((url) => url.toString()).toList();
    // await preferences.setStringList("image", imageStrings);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DescriptionPage(product: postModel)));
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PostViewPage(postModel: postModel)));
  }

  searchData(String searchText) {
    //   if (searchText.isEmpty) {
    //     postData = _searchedProds;
    //   } else {
    //     postData = _searchedProds.where((product) =>
    //     product.title?.toLowerCase().contains(searchText.toLowerCase()) ?? false).toList();
    //   }
    // }
    print("SearchText: $searchText");
    Provider.of<PostProvider>(context, listen: false).searchData(searchText);
  }
}
