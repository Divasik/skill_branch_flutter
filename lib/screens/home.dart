import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/services.dart';

import 'feed_screen.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  int currentTab = 0;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Widget _connectivityErrorOverlayContent;

  List<Widget> pages = [
    Feed(),
    Container(),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavyBar(
              onItemSelected: (int index) {
                setState(() {
                  currentTab = index;
                });
              },
              currentTab: currentTab,
              itemCornerRadius: 8,
              curve: Curves.ease,
              items: [
                BottomNavyBarItem(
                    asset: AppIcons.home,
                    title: Text('Feed'),
                    activeColor: AppColors.dodgerBlue,
                    inactiveColor: AppColors.manatee),
                BottomNavyBarItem(
                    asset: AppIcons.home,
                    title: Text('Search'),
                    activeColor: AppColors.dodgerBlue,
                    inactiveColor: AppColors.manatee),
                BottomNavyBarItem(
                    asset: AppIcons.home,
                    title: Text('User'),
                    activeColor: AppColors.dodgerBlue,
                    inactiveColor: AppColors.manatee)
              ]),
      body: pages[currentTab],
    );
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.none:
        if(_connectivityErrorOverlayContent == null) {
          _connectivityErrorOverlayContent = Positioned(
            top: MediaQuery.of(context).viewInsets.top + 50,
            child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.mercury
                  ),
                  child: Text('No internet connection'),
                ),
              ),
            ),
          );
        }
        ConnectivityOverlay().showOverlay(context, _connectivityErrorOverlayContent);
        break;
      default:
        ConnectivityOverlay().removeOverlay(context);
        break;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    overlayEntry = OverlayEntry(builder: (context) => child);
    Overlay.of(context).insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    if(overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar(
      {Key key,
      this.backgroundColor = Colors.white,
      this.showElevation = true,
      this.containerHeight = 56,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.items,
      this.onItemSelected,
      this.currentTab,
      this.animationDuration = const Duration(milliseconds: 270),
      this.itemCornerRadius = 24,
      this.curve})
      : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornerRadius;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
        if (showElevation) const BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: SafeArea(
          child: Container(
        width: double.infinity,
        height: containerHeight,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                    isSelected: currentTab == index,
                    item: item,
                    backgroundColor: backgroundColor,
                    animationDuration: animationDuration,
                    itemCornerRadius: itemCornerRadius,
                    curve: curve),
              );
            }).toList()),
      )),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget(
      {@required this.isSelected,
      @required this.item,
      @required this.backgroundColor,
      @required this.animationDuration,
      this.curve = Curves.linear,
      @required this.itemCornerRadius})
      : assert(animationDuration != null, 'animationDuration is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(item != null, 'item is null'),
        assert(backgroundColor != null, 'backgroundColor is null'),
        assert(itemCornerRadius != null, 'itemCornerRadius is null');

  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornerRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: isSelected
          ? 150
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      curve: curve,
      decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius)),
      child: Row(
        children: <Widget>[
          Icon(item.asset,
              size: 20,
              color: isSelected ? item.activeColor : item.inactiveColor),
          SizedBox(width: 4),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: DefaultTextStyle.merge(
                      child: item.title,
                      textAlign: item.textAlign,
                      maxLines: 1,
                      style: TextStyle(
                          color: isSelected
                              ? item.activeColor
                              : item.inactiveColor,
                          fontWeight: FontWeight.bold))))
        ],
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem(
      {this.asset,
      this.title,
      this.activeColor,
      this.inactiveColor,
      this.textAlign}) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'Title is null');
  }

  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
