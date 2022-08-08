import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/product_bloc/product_cubit.dart';
import 'package:shop_app/blocs/product_bloc/product_state.dart';
import 'package:shop_app/screens/products/components/product_widget.dart';
import 'package:shop_app/theme.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final int categoryId;
  const Body({Key? key, required this.categoryId}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ProductsCubit productsCubit;
  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    productsCubit.getProducts(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit,ProductsState>(
        builder: (context,state) {
        return state is ProductsSuccessful?
        GridView.builder(
          itemCount: state.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,childAspectRatio: 0.9),
          itemBuilder: (BuildContext context, int index) {
             return Padding(
               padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10),
                 horizontal: getProportionateScreenWidth(10),),
               child: ProductWidget(product: state.products[index]),
             );
          },
        ):  state is ProductsFailed?
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('This category has no products for now',style:
              TextStyle(color: Colors.grey[700],fontSize: 17),),
          ),
        ) :    GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              return loadProductsShimmer();
            }
        );
      }
    );
  }
}
