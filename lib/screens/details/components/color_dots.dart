import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/product_bloc/product_cubit.dart';
import 'package:shop_app/models/product_model.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key? key,
    required this.product, required this.count,
  }) : super(key: key);

  final Products product;
  final int count;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var productCount;
  late ProductsCubit productsCubit;
  @override
  void initState() {
    productsCubit =  BlocProvider.of<ProductsCubit>(context);
    productCount = widget.count;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: getProportionateScreenWidth(30),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){
            if(productCount < widget.product.count! - 1){
              setState(() {
                productCount++;
                productsCubit.myCount = productCount;
              });
            }
          }, icon: Icon(Icons.add_circle_outlined)),
          Text(
            '$productCount',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: getProportionateScreenWidth(12.5),
            ),
          ),
          IconButton(onPressed: (){
            if(productCount - 1 > 0){
              setState(() {
                productCount--;
                productsCubit.myCount = productCount;
              });
            }
          }, icon: Icon(Icons.remove_circle_outline)),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
