part of 'camera.dart';

class Plane {
  Plane(Map<dynamic, dynamic> data) {
    bytes = data['bytes'];
    bytesPerPixel = data['bytesPerPixel'];
    bytesPerRow = data['bytesPerRow'];
    height = data['height'];
    width = data['width'];

    var out = new File('output_Plane.txt').openWrite();
    out.write(
        'PLANE\nbytes=$bytes\n\bytesPerPixel=$bytesPerPixel\n\bytesPerRow=$bytesPerRow\n\height=$height\n\nwidth=$width');
    out.close();
  }

  Uint8List bytes;
  int bytesPerPixel;
  int bytesPerRow;
  int height;
  int width;
}

enum ImageFormatGroup {
  unknown,
  yuv420,

  bgra8888,
}

class ImageFormat {
  ImageFormat(this.raw) {
    group = _asImageFormatGroup(raw);

    var out = new File('output_ImageFormat.txt').openWrite();
    out.write('ImageFormat\raw=$raw\n\ngroup=$group');
    out.close();
  }

  ImageFormatGroup group;
  dynamic raw;
}

ImageFormatGroup _asImageFormatGroup(dynamic rawFormat) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    if (rawFormat == 35) {
      return ImageFormatGroup.yuv420;
    }
  }

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    switch (rawFormat) {
      case 875704438:
        return ImageFormatGroup.yuv420;
      case 1111970369:
        return ImageFormatGroup.bgra8888;
    }
  }

  return ImageFormatGroup.unknown;
}

class CameraImage {
  CameraImage(Map<dynamic, dynamic> data) {
    format = ImageFormat(data['format']);
    height = data['height'];
    width = data['width'];
    planes = List<Plane>.unmodifiable(data['planes'].map((dynamic planeData) => Plane(planeData)));

    var out = new File('output_CameraImage.txt').openWrite();
    out.write('CameraImage\nformat=$format\n\nheight=$height\n\nwidth=$width\n\nplanes=$planes');
    out.close();
  }

  ImageFormat format;
  int height;
  int width;
  List<Plane> planes;
}
