import 'package:attendance/services/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BorderNetworkImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final double margin;

  BorderNetworkImage({
    this.url,
    this.fit = BoxFit.contain,
    this.margin = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      imageBuilder: (context, image) {
        return Container(
          width: width(context),
          height: 300,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: image,
              fit: fit,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, _, __) {
        return SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, _, __) {
        return Container(
          width: width(context),
          height: 300,
          margin: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Tidak ada gambar',
              style: poppinsBlackw400.copyWith(color: Colors.black45),
            ),
          ),
        );
      },
    );
  }
}
