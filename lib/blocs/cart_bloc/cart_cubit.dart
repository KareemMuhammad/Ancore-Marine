import 'package:bloc/bloc.dart';
import 'package:shop_app/blocs/cart_bloc/cart_state.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/repositories/cart_repo.dart';

class CartCubit extends Cubit<CartState>{
  final CartRepo? cartRepo;
  CartCubit({this.cartRepo}) : super(CartInitial());

  List<Orders> ordersInCart = [];

  getMyOrders(String token)async{
    emit(CartLoading());
    CartHolder holder = await cartRepo!.getCartResponse(token);
    if(holder.orders!.isNotEmpty){
      ordersInCart = holder.orders!;
      emit(CartSuccessful(holder));
    }else{
      emit(CartFailed());
    }
  }

 Future addToCart(String token,int productId,int count,int price)async{
    emit(CartLoading());
    String msg = '';
    if(ordersInCart.isNotEmpty) {
      for (var order in ordersInCart) {
        if (productId == order.productId) {
          if (order.count! < count) {
            await removeFromCart(token, productId);
            msg =
            await cartRepo!.addToCartResponse(token, productId, count, price);
            break;
          } else {
            msg = 'هذا الطلب تم وضعه بالعربة من فضلك اختر كمية اكثر للاستمرار';
            break;
          }
        } else {
          msg =
          await cartRepo!.addToCartResponse(token, productId, count, price);
          break;
        }
      }
    }else{
      msg =
      await cartRepo!.addToCartResponse(token, productId, count, price);
    }

    if(msg.isNotEmpty){
      getMyOrders(token);
    }
    return msg;
  }

  Future removeFromCart(String token,int productId)async{
    emit(CartLoading());
    bool msg = await cartRepo!.removeFromCartResponse(token, productId);
    if(msg){
      getMyOrders(token);
    }
    return msg;
  }

  clearAllCart(String token)async{
    emit(CartLoading());
    if(ordersInCart.isNotEmpty){
      for(var order in ordersInCart){
        await removeFromCart(token, order.product!.id!);
      }
    }
    getMyOrders(token);
  }

}