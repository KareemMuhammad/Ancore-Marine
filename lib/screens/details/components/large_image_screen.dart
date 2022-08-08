import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../../constants.dart';
import '../../../models/product_model.dart';
import '../../../size_config.dart';

class LargeImageScreen extends StatefulWidget {
  final Products product;
  final List<Images> images;
  const LargeImageScreen({Key? key,required this.product,
    required this.images}) : super(key: key);

  @override
  _LargeImageScreenState createState() => _LargeImageScreenState();
}

class _LargeImageScreenState extends State<LargeImageScreen> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight - 200,
              child: PhotoView(
                backgroundDecoration: BoxDecoration(
                 color: Colors.white
                ),
                imageProvider: CachedNetworkImageProvider(
                  widget.images[selectedImage].name!,),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(widget.images.length,
                      (index) => buildSmallProductPreview(index)),
            ],
          )
        ],
      ),
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
