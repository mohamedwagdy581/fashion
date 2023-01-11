import 'package:fashion/modules/cart/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';

import '../modules/favorites/favorites.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/components/horizontal_listview.dart';
import '../shared/components/products.dart';
import '../shared/network/local/cash_helper.dart';
import '../modules/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var user = FirebaseAuth.instance.currentUser;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    uId = CashHelper.getData(key: 'uId');

    Widget carouselImages = SizedBox(
      height: height * 0.28,
      child: Carousel(
        images: [
          Image.asset(
            'assets/images/c1.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/m1.jpeg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/m2.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/w1.jpeg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/w3.jpeg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/w4.jpeg',
            fit: BoxFit.cover,
          ),
        ],
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 1500),
        dotSize: 5.0,
        dotSpacing: 20.0,
        dotColor: Colors.white,
        dotIncreasedColor: Colors.pink,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        dotVerticalPadding: 10.0,
        showIndicator: true,
        indicatorBgPadding: 0.0,
        boxFit: BoxFit.cover,
        borderRadius: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Fashion App',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              navigateTo(context, CartScreen());
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
              currentAccountPicture: const CircleAvatar(
                radius: 40.0,
                backgroundImage:

                NetworkImage(
                  'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png',
                ),
                /*uId != null ? NetworkImage(user!.photoURL!) : const NetworkImage(
                  'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png',
                ),*/
              ),
              accountName: uId != null ?  Text('${user?.displayName}') : const Text(''),
              accountEmail: uId != null ?  Text('${user?.email}') : Container(
                width: width * 0.5,
                padding: const EdgeInsets.only(bottom: 15,left: 5,right: 60),
                child: defaultButton(
                  onPressed: ()
                  {
                    navigateAndFinish(context, LoginScreen());
                  },
                  text: 'Login Now',
                  backgroundColor: Colors.deepOrange,
                ),
              ),
            ),
            customListTile(
              onTapped: () {},
              title: 'Home Screen',
              leadingWidget: const Icon(
                Icons.home_rounded,
                size: 30.0,
                color: Colors.red,
              ),
            ),
            customListTile(
              onTapped: () {},
              title: 'My Account',
              leadingWidget: const Icon(
                FontAwesomeIcons.person,
                size: 30.0,
                color: Colors.pinkAccent,
              ),
            ),
            customListTile(
              onTapped: () {},
              title: 'My Orders',
              leadingWidget: const Icon(
                Icons.shopping_basket,
                size: 30.0,
                color: Colors.red,
              ),
            ),
            customListTile(
              onTapped: () {
                navigateTo(context, CartScreen());
              },
              title: 'Shopping Cart',
              leadingWidget: const Icon(
                Icons.shopping_cart,
                size: 30.0,
                color: Colors.pink,
              ),
            ),
            customListTile(
              onTapped: ()
              {
                navigateTo(context,  const FavoritesScreen());
              },
              title: 'Favorites',
              leadingWidget: const Icon(
                FontAwesomeIcons.heartCircleCheck,
                size: 30.0,
                color: Colors.red,
              ),
            ),
            const Divider(
              thickness: 1.5,
            ),
            customListTile(
              onTapped: () {},
              title: 'Settings',
              leadingWidget: const Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.blue,
              ),
            ),
            customListTile(
              onTapped: () {},
              title: 'About',
              leadingWidget: const Icon(
                Icons.handshake_rounded,
                size: 30.0,
                color: Colors.grey,
              ),
            ),
            customListTile(
              onTapped: ()
              {
                signOut(context);
              },
              title: 'Sign Out',
              leadingWidget: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carouselImages,
          const Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              top: 10.0,
              bottom: 5.0,
            ),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const HorizontalListView(),
          const Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              top: 10.0,
              bottom: 5.0,
            ),
            child: Text(
              'Recent Products',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Products(),
          ),
        ],
      ),
    );
  }
}

