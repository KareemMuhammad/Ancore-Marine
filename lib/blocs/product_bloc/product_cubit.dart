import 'package:bloc/bloc.dart';
import 'package:shop_app/blocs/product_bloc/product_state.dart';
import 'package:shop_app/repositories/products_repo.dart';
import '../../models/product_model.dart';

class ProductsCubit extends Cubit<ProductsState>{
  final ProductsRepo? productsRepo;
  ProductsCubit({this.productsRepo}) : super(ProductsInitial());

  List<Products>? productsList;
  int _myCount = 1;


  int get myCount => _myCount;

  set myCount(int value) {
    _myCount = value;
  }

  void getProducts(int categoryId)async{
    emit(ProductsLoading());
    ProductHolder productsHolder = await productsRepo!.getProductByCategoryResponse(categoryId);
    if(productsHolder.products!.isNotEmpty){
      productsList = productsHolder.products;
      emit(ProductsSuccessful(productsList!));
    }else{
      emit(ProductsFailed());
    }
  }

}