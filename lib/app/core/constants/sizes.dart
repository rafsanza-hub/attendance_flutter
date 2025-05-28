import 'package:flutter/material.dart';

class AppSizes {
  // Private constructor to prevent instantiation
  AppSizes._();

  // Padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double iconXxl = 64.0;

  // Font sizes
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSizeXxl = 24.0;
  static const double fontSizeXxxl = 32.0;

  // Button sizes
  static const double buttonHeight = 48.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;
  static const double buttonElevation = 4.0;

  // AppBar height
  static const double appBarHeight = 56.0;

  // Image sizes
  static const double imageThumbSize = 80.0;
  static const double imageCardHeight = 160.0;
  static const double imageCarouselHeight = 200.0;

  // Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;

  // Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;
  static const double borderRadiusXl = 16.0;

  // Divider height
  static const double dividerHeight = 1.0;

  // Product item dimensions
  static const double productImageSize = 120.0;
  static const double productImageRadius = 16.0;
  static const double productItemHeight = 160.0;

  // Input field
  static const double inputFieldRadius = 12.0;
  static const double spaceBtwInputFields = 16.0;

  // Card sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

  // Loading indicator size
  static const double loadingIndicatorSize = 36.0;

  // Grid view spacing
  static const double gridViewSpacing = 16.0;

  // Responsive breakpoints
  static const double mobileWidth = 600.0;
  static const double tabletWidth = 900.0;
  static const double desktopWidth = 1200.0;

  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 350);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Responsive helper methods
  static double responsiveSize(BuildContext context, double mobileSize,
      [double? tabletSize, double? desktopSize]) {
    final width = MediaQuery.of(context).size.width;

    if (width >= desktopWidth && desktopSize != null) {
      return desktopSize;
    } else if (width >= tabletWidth && tabletSize != null) {
      return tabletSize;
    }
    return mobileSize;
  }

  static EdgeInsets responsivePadding(BuildContext context,
      {EdgeInsets? mobile, EdgeInsets? tablet, EdgeInsets? desktop}) {
    final width = MediaQuery.of(context).size.width;

    if (width >= desktopWidth && desktop != null) {
      return desktop;
    } else if (width >= tabletWidth && tablet != null) {
      return tablet;
    }
    return mobile ?? EdgeInsets.all(AppSizes.md);
  }
}
