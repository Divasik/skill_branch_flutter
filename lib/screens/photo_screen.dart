import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImage extends StatefulWidget {

  FullScreenImage({Key key,
    this.name = "",
    this.userName = "",
    this.userPhoto = "",
    this.altDescription = "",
    this.photo = "",
    this.heroTag = ""
  }): super(key: key);

  final String name;
  final String userName;
  final String userPhoto;
  final String altDescription;
  final String photo;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImageState();
  }

}

class _FullScreenImageState extends State<FullScreenImage> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _avatarOpacity;
  Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this
    );

    _avatarOpacity = Tween<double>(begin: 0, end: 1)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.5, curve: Curves.ease),
      ),
    );

    _textOpacity = Tween<double>(begin: 0, end: 1)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1, curve: Curves.ease),
      ),
    );

    _controller.forward();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: () { Navigator.pop(context, false); },),
        title: Text('Photo'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.white),
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return ClaimBottomSheet();
                });
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildItem(context)
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: widget.heroTag,
          child: Photo(photoLink: widget.photo),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
              widget.altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black)),),
        _buildPhotoMeta(context)
      ],
    );
  }

  Widget _buildPhotoMeta(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: <Widget>[
          AnimatedBuilder(
            builder: _buildUserRow,
            animation: _controller,
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
                onTap: () {
                  showSaveDialog(context);
                },
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

  Widget _buildUserRow(BuildContext context, Widget child) {
    return Row(
      children: <Widget>[
        FadeTransition(
          child: UserAvatar(avatarLink: widget.userPhoto),
          opacity: _avatarOpacity,
        ),
        SizedBox(width: 6),
        FadeTransition(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.name, style: AppStyles.h1Black),
              Text("@${widget.userName}", style: AppStyles.h5Black.copyWith(color: AppColors.manatee)),
            ],
          ),
          opacity: _textOpacity,
        )
      ],
    );
  }

  void showSaveDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Downloading photos'),
      content: Text('Are you sure you want to upload a photo?'),
      actions: [
        FlatButton(
          child: Text('Download'),
          onPressed: () {
            GallerySaver.saveImage(widget.photo);
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ));
  }

}