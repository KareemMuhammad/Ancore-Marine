import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/details/components/large_image_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product, required this.images,
  }) : super(key: key);

  final Products product;
  final List<Images> images;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(milliseconds: 400),
                    child: LargeImageScreen(product: widget.product, images: widget.images)));
          },
          child: SizedBox(
            width: getProportionateScreenWidth(238),
            child: AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: widget.product.id.toString(),
                child: CachedNetworkImage(imageUrl: widget.images[selectedImage].name!),
              ),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: CachedNetworkImage(imageUrl: widget.images[index].name!),
      ),
    );
  }
}
