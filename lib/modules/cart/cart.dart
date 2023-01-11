import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/home_layout/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/cubit/states.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  final int? quantity;

  CartScreen({Key? key, this.quantity}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var promoCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final currentUser = FirebaseAuth.instance.currentUser;
    final Stream<QuerySnapshot> fireStore = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('cart')
        .snapshots();
    final List storeDocs = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: BackButton(
          onPressed: () {
            navigateAndFinish(context, const HomeScreen());
          },
        ),
        title: const Text(
          'Cart',
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
      body: BlocConsumer<AppCubit, AppStates>(
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
                            height: height,
                            width: width,
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
      bottomNavigationBar: SizedBox(
        height: height * 0.26,
        child: Card(
          elevation: 15.0,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 8,
                        child: defaultTextFormField(
                          controller: promoCodeController,
                          keyboardType: TextInputType.text,
                          label: 'Add Promo Code',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email must not be Empty!';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: width * 0.032,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: height * 0.055,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Apply Code',
                              style: TextStyle(
                                fontSize: 15.8,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        '\$0.00',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Delivery Type : ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            height: height * 0.032,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.blue[50],
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: const Text(
                              'Normal',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Divider(thickness: 2,),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.008,
                              ),
                              Text(
                                '$quantity\$',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: defaultButton(
                          onPressed: () {},
                          text: 'Checkout',
                          backgroundColor: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


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
    required height,
    required width,
  }) {
    return Padding(
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
                    width: width * 0.29,
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
                        SizedBox(
                          height: height * 0.015,
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
                        SizedBox(
                          height: height * 0.015,
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 10, top: 5, bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: IconButton(
                            onPressed: () {
                              AppCubit.get(context).plus();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                          child: Text('${AppCubit.get(context).counter}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13.0),
                          child: IconButton(
                            onPressed: () {
                              AppCubit.get(context).minus();
                            },
                            icon: const Icon(
                              Icons.minimize,
                              color: Colors.grey,
                            ),
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
    );
  }

}
