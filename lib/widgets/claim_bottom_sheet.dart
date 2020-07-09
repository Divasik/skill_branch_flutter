import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {

  final List<String> types = [
    'adult',
    'harm',
    'bully',
    'spam',
    'copyright',
    'hate'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mercury,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(types.length, (index) => Container(
            height: 50,
            child: Material(
              child: InkWell(
                splashColor: AppColors.dodgerBlue,
                child: Center(
                  child: Text(
                    types[index].toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ))
        ),
      ),
    );
  }

}