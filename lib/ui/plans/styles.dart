import 'dart:ui';

final Size physicalSize = window.physicalSize;
final double devicePixelRatio = window.devicePixelRatio;

final double screenWidth = physicalSize.width / devicePixelRatio;
final double screenHeight = physicalSize.height / devicePixelRatio;

final double safeAreaTop = window.padding.top / devicePixelRatio;
final double safeAreaBottom = window.padding.bottom / devicePixelRatio;

/// Paddings
final double contentVerticalPadding = 5;
final double contentHorizontalPadding = 8;

/// Sizes
final double planItemSize = 60;
final double planItemSubtitleFontSize = 16.0;

/// Radiuses
final double planItemBorderRadius = 5;
