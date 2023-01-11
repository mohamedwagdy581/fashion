import 'package:fashion/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/user_model.dart';
import '../../components/constants.dart';
import '../local/cash_helper.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // Get context to Easily use in a different places in all Project
  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  ProductModel? productModel;
  // Add To Cart
  void addToCart(
      {
        required String id,
        required String name,
        required String image,
        required int price,
        required int oldPrice,
        required String details,
        required String brand,
        required String color,
        required String size,
      })
  {
    emit(CartItemLoadingState());
    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('users').doc(user?.uid).collection('cart').doc().get().then((value)
    {

      createCartItem(
        id: id,
        name: name,
        image: image,
        price: price,
        oldPrice: oldPrice,
        details: details,
        brand: brand,
        color: color,
        size: size,
      );
    }).catchError((error)
    {
      emit(CartItemErrorState(error.toString()));
    });
  }

  // Create New Cart Item
  void createCartItem(
      {
        required String id,
        required String name,
        required String image,
        required int price,
        required int oldPrice,
        required String details,
        required String brand,
        required String color,
        required String size,
      })
  {

    var user = FirebaseAuth.instance.currentUser;
    ProductModel model = ProductModel(
      id: id,
      name: name,
      image: image,
      price: price,
      oldPrice: oldPrice,
      details: details,
      brand: brand,
      size: size,
      color: color,
    );

    FirebaseFirestore.instance
        .collection('users').doc(user?.uid).collection('cart').doc().set(model.toMap())
        .then((value)
    {
      emit(CreateCartItemSuccessState());
    }).catchError((error)
    {
      emit(CreateCartItemErrorState(error.toString()));
    });
  }
  // Function to Change Theme mode
  bool isFavorite = false;
  int? currentIndex;

  void changeFavorite({bool? fromShared}) {
    if (fromShared != null) {
      isFavorite = fromShared;
      emit(AppChangeFavoriteState());
    } else {
      isFavorite = !isFavorite;
      CashHelper.setBoolean(key: 'isFavorite', value: isFavorite).then((value) {
        emit(AppChangeFavoriteState());
      });
    }
  }

  int counter = 1;
  void plus()
  {
    counter++;
    emit(AppCounterPlusState());
  }
  void minus()
  {
    counter--;
    emit(AppCounterMinusState());
  }

  // Function to Change Theme mode
  bool isDark = false;

  void changeAppModeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeThemeState());
    } else {
      isDark = !isDark;
      CashHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeThemeState());
      });
    }
  }


}
