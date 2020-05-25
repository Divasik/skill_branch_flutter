import 'package:FlutterGalleryApp/res/res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {

  Photo({Key key, this.photoLink, this.tag, this.onTap}) : super(key: key);

  final String photoLink;
  final String tag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17)),
        child: Container(
          color: AppColors.grayChateau,
          child: Hero(
            tag: tag,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: CachedNetworkImage(
                  imageUrl: photoLink,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

}