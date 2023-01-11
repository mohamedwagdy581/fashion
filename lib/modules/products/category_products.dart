import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../product_details.dart';


class CategoryProducts extends StatelessWidget {
  final String collection;
  const CategoryProducts({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> fireStore =
    FirebaseFirestore.instance.collection(collection).snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: fireStore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    prodId: storeDocs[index]['id'],
                    prodPicture: storeDocs[index]['image'],
                    prodPrice: storeDocs[index]['price'],
                    prodOldPrice: storeDocs[index]['oldPrice'],
                    prodDetails: storeDocs[index]['details'],
                    prodBrand: storeDocs[index]['brand'],
                    prodColor: storeDocs[index]['color'],
                    prodSize: storeDocs[index]['size'],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

  Widget singleProduct({
    required context,
    required prodName,
    required prodPicture,
    required prodPrice,
    required prodOldPrice,
    required prodDetails,
    required prodBrand,
    required prodColor,
    required prodSize,
    required prodId,
  }) =>
      Card(
        child: Hero(
            tag: Text(prodName),
            child: Material(
              child: InkWell(
                onTap: () {
                  navigateTo(
                    context,
                    ProductDetailsScreen(
                      productDetailsName: prodName,
                      productDetailsPicture: prodPicture,
                      productDetailsPrice: prodPrice,
                      productDetailsOldPrice: prodOldPrice,
                      productDetails: prodDetails,
                      productDetailsBrand: prodBrand,
                      productDetailsColor: prodColor,
                      productDetailsSize: prodSize,
                      productDetailsId: prodId,
                    ),
                  );
                },
                child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 1.0,
                        bottom: 1.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              prodName,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Text(
                            '$prodPrice \$',
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Image.network(
                    prodPicture,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )),
      );
