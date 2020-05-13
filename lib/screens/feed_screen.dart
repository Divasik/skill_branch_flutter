

import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class Feed extends StatefulWidget {

  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
        return Column(children: <Widget>[
          _buildItem(),
          Divider(
            thickness: 2,
            color: AppColors.mercury,
          )
        ],
        );
      }),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Photo(photoLink: kFlutterDash),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
              'This is Flutter dash. I love him :)',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black)),)
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(avatarLink: 'https://avatars2.githubusercontent.com/u/3737842?s=460&u=08ee3419c049073a924f2255fc08667430651f55&v=4'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Dmitriy Panfilov', style: AppStyles.h2Black),
                  Text('@panfilov_dmitriy', style: AppStyles.h5Black.copyWith(color: AppColors.manatee)),
                ],
              )
            ],
          ),
          LikeButton(10, true)
        ],
      ),
    );
  }

}