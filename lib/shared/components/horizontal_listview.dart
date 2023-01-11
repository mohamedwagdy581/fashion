import 'package:flutter/material.dart';

import '../../modules/products/category_products.dart';
import 'components.dart';

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          category(
            onTapped: ()
            {
              navigateTo(context, const CategoryProducts(collection: 'shirts',));
            },
            categoryImage: 'assets/images/cats/tshirt.png',
            categoryCaption: 'Shirt',
          ),
          category(
            onTapped: ()
            {
              navigateTo(context, const CategoryProducts(collection: 'dress',));
            },
            categoryImage: 'assets/images/cats/dress.png',
            categoryCaption: 'Dress',
          ),
          category(
            onTapped: ()
            {
              navigateTo(context, const CategoryProducts(collection: 'casual',));
            },
            categoryImage: 'assets/images/cats/informal.png',
            categoryCaption: 'Casual',
          ),
          category(
            onTapped: ()
            {
              navigateTo(context, const CategoryProducts(collection: 'formal',));
            },
            categoryImage: 'assets/images/cats/formal.png',
            categoryCaption: 'Formal',
          ),
          category(
            onTapped: ()
            {
              navigateTo(context, const CategoryProducts(collection: 'shoes',));
            },
            categoryImage: 'assets/images/cats/shoe.png',
            categoryCaption: 'Shoe',
          ),
          category(
            onTapped: ()
            {
              navigateTo(context, const CategoryProducts(collection: 'accessories',));
            },
            categoryImage: 'assets/images/cats/accessories.png',
            categoryCaption: 'Accessories',
          ),
        ],
      ),
    );
  }

  Widget category({
    required VoidCallback onTapped,
    required String categoryImage,
    required categoryCaption,
  }) =>
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          width: 78,
          child: customListTileWidget(
            onTapped: onTapped,
            title: Image.asset(
              categoryImage,
              width: 60.0,
              height: 55.0,
            ),
            subTitle: Text(
              categoryCaption,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}
