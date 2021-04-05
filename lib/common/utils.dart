import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class LoadImageWithLoader extends StatelessWidget {
  final String url;
  final bool blurred;

  const LoadImageWithLoader({Key key, this.url, this.blurred = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sigma = blurred ? 10.0 : 0.0;

    return ExtendedImage.network(
      url,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(child: CircularProgressIndicator.adaptive());
            break;
          case LoadState.completed:
            return Stack(
              children: [
                ExtendedRawImage(
                  image: state.extendedImageInfo.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: sigma,
                        sigmaY: sigma,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  ),
                ),
              ],
            );
            break;
          case LoadState.failed:
            return Text('Error while loading image. fail');
            break;
          default:
            return Text('Error while loading image.');
        }
      },
    );
  }
}

class LoadAssetsImage extends StatelessWidget {
  final String source;

  const LoadAssetsImage({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      source,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
