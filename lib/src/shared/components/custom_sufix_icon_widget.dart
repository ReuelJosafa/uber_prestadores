import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSufixIcon extends Container {
  final Color backgroundColor;
  final String assetName;
  final bool isSearching;
  final void Function()? onTap;
  CustomSufixIcon({
    Key? key,
    required this.backgroundColor,
    required this.assetName,
    this.onTap,
    this.isSearching = false,
  }) : super(
          key: key,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(4)),
              color: backgroundColor),
          child: GestureDetector(
            onTap: onTap,
            child: isSearching
                ? const Icon(Icons.close, color: Colors.white)
                : SvgPicture.asset(
                    assetName,
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
          ),
        );
}
