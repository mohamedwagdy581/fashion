import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/home_layout/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/cubit/states.dart';
import '../cart/cart.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final int quantity = AppCubit.get(context).counter;
    final currentUser = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> fireStore = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('favorites')
        .snapshots();
    final List storeDocs = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: BackButton(
          onPressed: ()
          {
            navigateAndFinish(context, const HomeScreen());
          },
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async
        {
          setState(() {});
        },
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: fireStore,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something Wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        storeDocs.clear();
                        snapshot.data!.docs
                            .map((DocumentSnapshot documentSnapshot) {
                          Map products =
                              documentSnapshot.data() as Map<String, dynamic>;
                          storeDocs.add(products);
                          products['uId'] = documentSnapshot.id;
                        }).toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: storeDocs.length,
                          itemBuilder: (context, index) {
                            return singleFavoriteProduct(
                              context: context,
                              prodId: storeDocs[index]['id'],
                              prodName: storeDocs[index]['name'],
                              prodPicture: storeDocs[index]['image'],
                              prodPrice: storeDocs[index]['price'],
                              prodOldPrice: storeDocs[index]['oldPrice'],
                              prodDetails: storeDocs[index]['details'],
                              prodBrand: storeDocs[index]['brand'],
                              prodColor: storeDocs[index]['color'],
                              prodSize: storeDocs[index]['size'],
                              onTaped: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              checkColor: currentIndex == index
                                  ? Colors.red
                                  : Colors.grey,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 25.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
        ),
        child: defaultButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add To Cart'),
                content: const Text(
                    'Press Add to confirm add this item to your cart.'),
                actions: [
                  customButton(
                    onPressed: ()
                    {
                      if(currentIndex != null)
                      {
                        AppCubit.get(context).addToCart(
                          id: storeDocs[currentIndex!]['id'],
                          name: storeDocs[currentIndex!]['name'],
                          image: storeDocs[currentIndex!]['image'],
                          price: storeDocs[currentIndex!]['price'],
                          oldPrice: storeDocs[currentIndex!]['oldPrice'],
                          details: storeDocs[currentIndex!]['details'],
                          brand: storeDocs[currentIndex!]['brand'],
                          color: storeDocs[currentIndex!]['color'],
                          size: storeDocs[currentIndex!]['size'],
                        );
                        showToast(
                          message:
                          'Product Added To Cart Successfully',
                          state: ToastStates.SUCCESS,
                        );
                        navigateTo(context, CartScreen(quantity: quantity,));
                      }else
                      {
                        return showToast(
                          message:
                          'Please Select Product to Add!!',
                          state: ToastStates.ERROR,
                        );
                      }
                    },
                    text: 'Add',
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            );
            //Navigator.pop(context);
          },
          text: 'Add To Cart',
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }

  int? currentIndex;

  Widget singleFavoriteProduct({
    required context,
    required prodId,
    required prodName,
    required prodPicture,
    required prodPrice,
    required prodOldPrice,
    required prodDetails,
    required prodBrand,
    required prodColor,
    required prodSize,
    required checkColor,
    required VoidCallback onTaped,
  }) =>
      Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            child: Card(
              child: Hero(
                tag: Text(prodName),
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 4.0,
                            right: 8.0,
                            top: 2.0,
                            bottom: 2.0,
                          ),
                          width: 120.0,
                          child: Image.network(
                            prodPicture,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                prodName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$prodSize , '),
                                  Text(
                                    '$prodColor',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$prodPrice\$',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: IconButton(
              onPressed: onTaped,
              icon: Icon(
                Icons.check_box,
                size: 30.0,
                color: checkColor,
              ),
            ),
          ),
        ],
      );

}
