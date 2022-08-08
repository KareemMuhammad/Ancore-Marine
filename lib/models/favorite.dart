import 'package:hive/hive.dart';
import 'package:shop_app/models/product_model.dart';
part 'favorite.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject{
  @HiveField(0)
  Products? product;
  Favorite({this.product});
}