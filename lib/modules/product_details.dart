import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/model/product_model.dart';
import 'package:fashion/shared/network/cubit/cubit.dart';
import 'package:fashion/shared/network/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import 'cart_screen.dart';
import '../home_layout/home_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productDetailsId;
  final String productDetailsName;
  final String productDetailsPicture;
  final int productDetailsPrice;
  final int productDetailsOldPrice;
  final String productDetails;
  final String productDetailsBrand;
  final String productDetailsColor;
  final String productDetailsSize;

  const ProductDetailsScreen({
    super.key,
    required this.productDetailsName,
    required this.productDetailsPicture,
    required this.productDetailsPrice,
    required this.productDetailsOldPrice,
    required this.productDetails,
    required this.productDetailsColor,
    required this.productDetailsSize,
    required this.productDetailsBrand,
    required this.productDetailsId,
  });

  Future addToFavorite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    ProductModel productModel = ProductModel(
      id: productDetailsId,
      name: productDetailsName,
      price: productDetailsPrice,
      oldPrice: productDetailsOldPrice,
      image: productDetailsPicture,
      details: productDetails,
      brand: productDetailsBrand,
      size: productDetailsSize,
      color: productDetailsColor,
    );
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    return collectionRef
        .doc(currentUser?.uid)
        .collection('favorites')
        .doc(productDetailsId)
        .set(productModel.toMap())
        .then((value) => debugPrint('added to favorite'));
  }
  Future removeFromFavorite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');
    return collectionRef
        .doc(currentUser?.uid)
        .collection('favorites')
        .doc(productDetailsId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.pink,
        title: InkWell(
          onTap: () {
            navigateAndFinish(context, const HomeScreen());
          },
          child: Text(productDetailsName, style: const TextStyle(color: Colors.white,),),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, const CartScreen());
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 270.0,
                  child: GridTile(
                    footer: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      height: 45.0,
                      color: Colors.white70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              productDetailsName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '\$$productDetailsPrice',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$$productDetailsOldPrice',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*ListTile(
                    leading: Text(
                      productDetailsName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '\$$productDetailsPrice',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$$productDetailsOldPrice',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                    ),
                    child: Image.network(
                      productDetailsPicture,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // =============== The Product Details ==============
                productDetailsShowing(
                  hintTitle: 'Product Size : ',
                  title: productDetailsSize,
                ),
                productDetailsShowing(
                  hintTitle: 'Product Color : ',
                  title: productDetailsColor,
                ),
                productDetailsShowing(
                  hintTitle: 'Product Brand : ',
                  title: productDetailsBrand,
                ),

                // =============== The First Button ==============
                /*Row(
              children: [
                customButtons(
                  title: 'Size',
                  onPressed: () {
                    customShowingDialog(
                      context: context,
                      title: 'Size',
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Small'),
                          Text('Medium'),
                          Text('Large'),
                          Text('X-Large'),
                        ],
                      ),
                    );
                  },
                ),
                customButtons(
                  title: 'Color',
                  onPressed: () {
                    customShowingDialog(
                      context: context,
                      title: 'Color',
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Red'),
                          Text('Blue'),
                          Text('Black'),
                          Text('White'),
                        ],
                      ),
                    );
                  },
                ),
                customButtons(
                  title: 'Quantity',
                  fontSize: 13.0,
                  onPressed: () {
                    customShowingDialog(
                      context: context,
                      title: 'Quantity',
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('1'),
                          Text('2'),
                          Text('3'),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),*/

                // ============== The Second Button ==============
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.red,
                        textColor: Colors.white,
                        elevation: 0.5,
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavorite();
                          if(AppCubit.get(context).isFavorite)
                          {
                            addToFavorite();
                          }else
                          {
                            removeFromFavorite();
                          }

                        },
                        icon: Icon(
                          AppCubit.get(context).isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(
                  thickness: 1.0,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 5.0,
                  ),
                  child: ListTile(
                    title: const Text(
                      'Product Details : ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(productDetails),
                  ),
                ),

                const Divider(
                  thickness: 1.0,
                ),

                // =================== Similar Products Text ==================
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Similar Products',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                //================= Similar Products =================
                SizedBox(
                  height: 300.0,
                  child: similarProd(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget customButtons({
    required String title,
    required VoidCallback onPressed,
    double? fontSize,
  }) =>
      Expanded(
        child: MaterialButton(
          onPressed: onPressed,
          color: Colors.white,
          textColor: Colors.grey,
          elevation: 0.2,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
              const Expanded(
                child: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
            ],
          ),
        ),
      );

  Future customShowingDialog({
    required context,
    required String title,
    required dynamic content,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            MaterialButton(
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );

  Widget productDetailsShowing({
    required String hintTitle,
    required String title,
  }) =>
      Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 5.0,
        ),
        child: Row(
          children: [
            Text(
              hintTitle,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget similarProd() {
    final Stream<QuerySnapshot> fireStore = FirebaseFirestore.instance
        .collection('products')
        .doc(productDetailsId)
        .collection('similarProducts')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: fireStore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something Wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final List storeDocs = [];
            snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
              Map products = documentSnapshot.data() as Map<String, dynamic>;
              storeDocs.add(products);
              products['uId'] = documentSnapshot.id;
            }).toList();
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: storeDocs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => singleProduct(
                context: context,
                prodName: storeDocs[index]['name'],
                prodPicture: storeDocs[index]['image'],
                prodPrice: storeDocs[index]['price'],
                prodOldPrice: storeDocs[index]['oldPrice'],
                prodDetails: storeDocs[index]['details'],
                prodBrand: storeDocs[index]['brand'],
                prodColor: storeDocs[index]['color'],
                prodSize: storeDocs[index]['size'],
                prodId: storeDocs[index]['id'],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
