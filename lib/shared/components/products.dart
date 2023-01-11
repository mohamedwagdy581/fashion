import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../modules/product_details.dart';
import 'components.dart';

class Products extends StatelessWidget {
  Products({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> fireStore =
  FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                    prodId: storeDocs[index]['id'],
                    prodName: storeDocs[index]['name'],
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
          }
    );
  }
}
