import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:flutter_base/enums/enums.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/colors.dart';
import 'package:flutter_base/values/constants.dart';
import 'package:flutter_base/widgets/image_loader_widget.dart';
import 'package:flutter_html/style.dart';

class PhotoGridWidget extends StatefulWidget {
  final int maxImages = 5; // Max images
  final List<String?> imageUrls; // Image Urls
  final Function? onImageClicked; // On image clicked
  final Function? onExpandClicked; // On expand clicked
  final widthScreen = Utils.getWidth() / 1.5; // Width screen
  final heightScreen = Utils.getWidth() * 9 / 16; // Height screen

  PhotoGridWidget({
    required this.imageUrls,
    required this.onImageClicked,
    required this.onExpandClicked,
    // this.maxImages = 5,
    Key? key,
  }) : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGridWidget> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    return Container(
      constraints: BoxConstraints(
          maxHeight: widget.heightScreen, maxWidth: widget.widthScreen),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: images,
      ),
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(
      min(numImages, widget.maxImages),
      (index) {
        String? imageUrl = widget.imageUrls[index];
        double widthImage = numImages == 1 || (numImages == 3 && index == 0)
            ? widget.widthScreen
            : numImages >= widget.maxImages && index >= 2
                ? widget.widthScreen / 3
                : widget.widthScreen / 2;
        double heightImage = numImages >= 3
            ? widget.heightScreen / 2
            : widget.heightScreen / 1.5;
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        return Column(
          children: [
            index == 0
                ? Row(
                    children: [
                      renderImage(index, imageUrl, heightImage, widthImage),
                      index == 0 && (numImages >= 4 || numImages == 2)
                          ? renderImage(index + 1, widget.imageUrls[index + 1],
                              heightImage, widthImage)
                          : Container(),
                    ],
                  )
                : Container(),
            index == 1 && numImages == 3 || index == 2 && numImages >= 4
                ? Row(
                    children: [
                      renderImage(index, imageUrl, heightImage, widthImage),
                      renderImage(index + 1, widget.imageUrls[index + 1],
                          heightImage, widthImage),
                      numImages == widget.maxImages
                          ? renderImage(index + 2, widget.imageUrls[index + 2],
                              heightImage, widthImage)
                          : Container(),
                      remaining > 0
                          ? renderLastImageLoader(
                              index + 2,
                              widget.imageUrls[index + 2],
                              heightImage,
                              widthImage,
                              remaining)
                          : Container(),
                    ],
                  )
                : Container(),
          ],
        );
      },
    );
  }

  /// Render image loader
  renderImage(
      int index, String? imageUrl, double heightImage, double widthImage) {
    return GestureDetector(
      child: ImageLoaderWidget(
        marginImage: EdgeInsets.all(0.0),
        imageUrl: imageUrl,
        heightImage: heightImage,
        widthImage: widthImage,
        shape: BoxShape.rectangle,
        imageLoaderType: ImageLoaderType.image,
        borderRadiusHolder: Constants.cornerRadius,
        renderImageBuilder: (imageProvider) => Container(
          width: widthImage,
          height: heightImage,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.cornerRadius)),
            border: Border.all(
              width: Constants.borderWidth,
              color: Colors.background,
              style: BorderStyle.solid,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      onTap: () => {
        widget.onImageClicked!(widget.imageUrls, index),
      },
    );
  }

  /// Render last image loader
  renderLastImageLoader(int index, String? imageUrl, double heightImage,
      double widthImage, int remaining) {
    return GestureDetector(
      onTap: () => widget.onExpandClicked!(widget.imageUrls, index),
      child: Stack(
        children: [
          renderImage(index, imageUrl, heightImage, widthImage),
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.cornerRadius)),
                border: Border.all(
                  width: Constants.borderWidth,
                  color: Colors.background,
                  style: BorderStyle.solid,
                ),
                color: Colors.blackLight,
              ),
              child: Text(
                '+' + remaining.toString(),
                style: TextStyle(
                    fontSize: FontSize.xxLarge.size, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
