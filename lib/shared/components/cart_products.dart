import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var cartProductsList = [
    {
      'productName': 'Blazer',
      'productPicture': 'assets/images/products/blazer1.jpeg',
      'productPrice': 200.00,
      'prodSize': 'M',
      'prodColor': 'Red',
      'prodQuantity': 2,
    },
    {
      'productName': 'Blazer',
      'productPicture': 'assets/images/products/blazer2.jpeg',
      'productPrice': 150.00,
      'prodSize': 'L',
      'prodColor': 'Green',
      'prodQuantity': 1,
    },
    {
      'productName': 'Dress',
      'productPicture': 'assets/images/products/dress1.jpeg',
      'productPrice': 300.00,
      'prodSize': 'S',
      'prodColor': 'Blue',
      'prodQuantity': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: cartProductsList.length,
      itemBuilder: (context, index) => cartSingleProduct(
        cartProdName: cartProductsList[index]['productName'],
        cartProdPicture: cartProductsList[index]['productPicture'],
        cartProdPrice: cartProductsList[index]['productPrice'],
        cartProdSize: cartProductsList[index]['prodSize'],
        cartProdColor: cartProductsList[index]['prodColor'],
        cartProdQuantity: cartProductsList[index]['prodQuantity'],
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1.0,
      ),
    );
  }
}

Widget cartSingleProduct({
  required cartProdName,
  required cartProdPicture,
  required cartProdPrice,
  required cartProdSize,
  required cartProdColor,
  required cartProdQuantity,
}) =>
    Card(
      child: ListTile(
        leading: Image.asset(
          cartProdPicture,
          width: 80.0,
        ),

        // =============== Cart Product Name  =================
        title: Text(
          cartProdName,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        // =============== Cart Product Details  ===============
        subtitle: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============= Product Size And Color Row  ===================
              Row(
                children: [
                  customSizeAndColorRow(
                    hintText: 'Size : ',
                    prodText: cartProdSize,
                  ),
                  customSizeAndColorRow(
                    hintText: 'Color : ',
                    prodText: cartProdColor,
                  ),
                ],
              ),
              // ========== Product Price  ====================
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '\$$cartProdPrice',
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: ()
                          {

                          },
                          icon: const Icon(
                            Icons.arrow_left,
                          ),
                        ),
                        Text(
                          '$cartProdQuantity',
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ============== Change Product Quantity  ==================
      ),
    );

Widget customSizeAndColorRow({
  required String hintText,
  required String prodText,
}) =>
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              hintText,
            ),
            Text(
              prodText,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
