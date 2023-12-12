import 'package:flutter/material.dart';

import '../utils.dart';

///
/// A set of preset values can be used to setup the menu of crop aspect ratio
/// options in the cropper view.
///
enum CropAspectRatioPreset {
  original,
  square,
  ratio3x2,
  ratio5x3,
  ratio4x3,
  ratio5x4,
  ratio7x5,
  ratio16x9
}

///
/// Crop style options. There're two supported styles, rectangle and circle.
/// These style will changes the shape of crop bounds, rectangle or circle bounds.
///
enum CropStyle { rectangle, circle }

///
/// Supported image compression formats
///
enum ImageCompressFormat { jpg, png }

class CropAspectRatio {
  final double ratioX;
  final double ratioY;

  const CropAspectRatio({required this.ratioX, required this.ratioY})
      : assert(ratioX > 0.0 && ratioY > 0.0);

  @override
  int get hashCode => ratioX.hashCode ^ ratioY.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is CropAspectRatio &&
          this.ratioX == other.ratioX &&
          this.ratioY == other.ratioY;
}

///
/// An abstract class encapsulates UI attributes for customization
///
abstract class PlatformUiSettings {
  Map<String, dynamic> toMap();
}

String aspectRatioPresetName(CropAspectRatioPreset? preset) {
  switch (preset) {
    case CropAspectRatioPreset.original:
      return 'original';
    case CropAspectRatioPreset.square:
      return 'square';
    case CropAspectRatioPreset.ratio3x2:
      return '3x2';
    case CropAspectRatioPreset.ratio4x3:
      return '4x3';
    case CropAspectRatioPreset.ratio5x3:
      return '5x3';
    case CropAspectRatioPreset.ratio5x4:
      return '5x4';
    case CropAspectRatioPreset.ratio7x5:
      return '7x5';
    case CropAspectRatioPreset.ratio16x9:
      return '16x9';
    default:
      return 'original';
  }
}

String cropStyleName(CropStyle style) {
  switch (style) {
    case CropStyle.rectangle:
      return 'rectangle';
    case CropStyle.circle:
      return 'circle';
    default:
      return 'rectangle';
  }
}

String compressFormatName(ImageCompressFormat format) {
  switch (format) {
    case ImageCompressFormat.jpg:
      return 'jpg';
    case ImageCompressFormat.png:
      return 'png';
    default:
      return 'jpg';
  }
}

///
/// A helper class provides properties that can be used to customize the cropper
/// view on Android.
///
/// The properties is mapped to fields of `Ucrop.Options` class in Ucrop library.
///
/// See: <https://github.com/Yalantis/uCrop/blob/master/ucrop/src/main/java/com/yalantis/ucrop/UCrop.java#L260>
///
class AndroidUiSettings extends PlatformUiSettings {
  /// desired text for Toolbar title
  final String? toolbarTitle;

  /// desired color of the Toolbar
  final Color? toolbarColor;

  /// desired color of status
  final Color? statusBarColor;

  /// desired color of Toolbar text and buttons (default is black)
  final Color? toolbarWidgetColor;

  /// desired background color that should be applied to the root view
  final Color? backgroundColor;

  /// desired resolved color of the active and selected widget and progress wheel middle line (default is darker orange)
  final Color? activeControlsWidgetColor;

  /// desired color of dimmed area around the crop bounds
  final Color? dimmedLayerColor;

  /// desired color of crop frame
  final Color? cropFrameColor;

  /// desired color of crop grid/guidelines
  final Color? cropGridColor;

  /// desired width of crop frame line in pixels
  final int? cropFrameStrokeWidth;

  /// crop grid rows count
  final int? cropGridRowCount;

  /// crop grid columns count
  final int? cropGridColumnCount;

  /// desired width of crop grid lines in pixels
  final int? cropGridStrokeWidth;

  /// set to true if you want to see a crop grid/guidelines on top of an image
  final bool? showCropGrid;

  /// set to true if you want to lock the aspect ratio of crop bounds with a fixed value
  /// (locked by default)
  final bool? lockAspectRatio;

  /// set to true to hide the bottom controls (shown by default)
  final bool? hideBottomControls;

  /// desired aspect ratio is applied (from the list of given aspect ratio presets)
  /// when starting the cropper
  final CropAspectRatioPreset? initAspectRatio;

  AndroidUiSettings({
    this.toolbarTitle,
    this.toolbarColor,
    this.statusBarColor,
    this.toolbarWidgetColor,
    this.backgroundColor,
    this.activeControlsWidgetColor,
    this.dimmedLayerColor,
    this.cropFrameColor,
    this.cropGridColor,
    this.cropFrameStrokeWidth,
    this.cropGridRowCount,
    this.cropGridColumnCount,
    this.cropGridStrokeWidth,
    this.showCropGrid,
    this.lockAspectRatio,
    this.hideBottomControls,
    this.initAspectRatio,
  });

  @override
  Map<String, dynamic> toMap() => {
        'android.toolbar_title': this.toolbarTitle,
        'android.toolbar_color': int32(this.toolbarColor?.value),
        'android.statusbar_color': int32(this.statusBarColor?.value),
        'android.toolbar_widget_color': int32(this.toolbarWidgetColor?.value),
        'android.background_color': int32(this.backgroundColor?.value),
        'android.active_controls_widget_color':
            int32(this.activeControlsWidgetColor?.value),
        'android.dimmed_layer_color': int32(this.dimmedLayerColor?.value),
        'android.crop_frame_color': int32(this.cropFrameColor?.value),
        'android.crop_grid_color': int32(this.cropGridColor?.value),
        'android.crop_frame_stroke_width': this.cropFrameStrokeWidth,
        'android.crop_grid_row_count': this.cropGridRowCount,
        'android.crop_grid_column_count': this.cropGridColumnCount,
        'android.crop_grid_stroke_width': this.cropGridStrokeWidth,
        'android.show_crop_grid': this.showCropGrid,
        'android.lock_aspect_ratio': this.lockAspectRatio,
        'android.hide_bottom_controls': this.hideBottomControls,
        'android.init_aspect_ratio':
            aspectRatioPresetName(this.initAspectRatio),
      };
}



typedef CropperDialogBuilder = Dialog Function(
  Widget cropper,
  Future<String?> Function() crop,
  void Function(RotationAngle) rotate,
);

typedef CropperRouteBuilder = PageRoute<String> Function(
  Widget cropper,
  Future<String?> Function() crop,
  void Function(RotationAngle) rotate,
);

enum CropperPresentStyle { dialog, page }

class CroppieBoundary {
  const CroppieBoundary({
    this.width,
    this.height,
  });

  final int? width;
  final int? height;
}

class CroppieViewPort {
  const CroppieViewPort({
    this.width,
    this.height,
    this.type,
  });

  final int? width;
  final int? height;
  final String? type;
}



enum RotationAngle {
  clockwise90,
  clockwise180,
  clockwise270,
  counterClockwise90,
  counterClockwise180,
  counterClockwise270,
}

int rotationAngleToNumber(RotationAngle angle) {
  switch (angle) {
    case RotationAngle.clockwise90:
      return -90;
    case RotationAngle.clockwise180:
      return -180;
    case RotationAngle.clockwise270:
      return -270;
    case RotationAngle.counterClockwise90:
      return 90;
    case RotationAngle.counterClockwise180:
      return 180;
    case RotationAngle.counterClockwise270:
      return 270;
  }
}

