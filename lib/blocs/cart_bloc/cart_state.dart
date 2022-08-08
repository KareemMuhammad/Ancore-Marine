import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/Cart.dart';

@immutable
abstract class CartState{}

class CartInitial extends CartState{}

class CartLoading extends CartState{}

class CartFailed extends CartState{}

class CartSuccessful extends CartState{
  final CartHolder cartHolder;

  CartSuccessful(this.cartHolder);
}