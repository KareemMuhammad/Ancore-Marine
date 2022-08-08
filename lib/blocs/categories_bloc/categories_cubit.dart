import 'package:bloc/bloc.dart';
import 'package:shop_app/blocs/categories_bloc/categories_state.dart';
import 'package:shop_app/repositories/categories_repo.dart';
import '../../models/category.dart';

class CategoriesCubit extends Cubit<CategoriesState>{
  final CategoriesRepo? categoriesRepo;
  CategoriesCubit({this.categoriesRepo}) : super(CategoriesInitial());

  List<Categories>? categories;

  void getCategories()async{
    emit(CategoriesLoading());
    CategoriesHolder categoriesHolder = await categoriesRepo!.getCategoriesResponse();
    if(categoriesHolder.categories!.isNotEmpty){
      categories = categoriesHolder.categories;
      emit(CategoriesSuccessful(categories!));
    }else{
      emit(CategoriesFailed());
    }
  }

}