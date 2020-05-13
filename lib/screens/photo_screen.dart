import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {

  FullScreenImage({Key key, this.name = "", this.userName = "", this.altDescription = "", this.photo = ""}): super(key: key);

  final String name;
  final String userName;
  final String altDescription;
  final String photo;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }

}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: () { Navigator.pop(context, false); },),
        title: Text('Photo'),
      ),
      body: Column(
        children: <Widget>[
          _buildItem()
        ],
      ),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Photo(photoLink: widget.photo),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
              widget.altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black)),),
        _buildPhotoMeta(),
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(avatarLink: 'https://avatars2.githubusercontent.com/u/3737842?s=460&u=08ee3419c049073a924f2255fc08667430651f55&v=4'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.name, style: AppStyles.h1Black),
                  Text("@${widget.userName}", style: AppStyles.h5Black.copyWith(color: AppColors.manatee)),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              LikeButton(10, true),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(color: AppColors.dodgerBlue, borderRadius: BorderRadius.circular(7)),
                  child: Text('Save', style: AppStyles.h4.copyWith(color: AppColors.white),),
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(color: AppColors.dodgerBlue, borderRadius: BorderRadius.circular(7)),
                  child: Text('Visit', style: AppStyles.h4.copyWith(color: AppColors.white),),
                ),
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}