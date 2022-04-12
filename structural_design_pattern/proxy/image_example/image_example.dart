abstract class Graphic {
  void displayImage();
}

// On System A
class RealImage implements Graphic {
  final String _filename;

  RealImage(this._filename) {
    _loadImageFromDisk();
  }

  /// Loads the image from the disk
  void _loadImageFromDisk() => print("Loading   $_filename");

  /// Displays the image
  void displayImage() => print("Displaying $_filename");
}

// On System B
class ProxyImage implements Graphic {
  final String _filename;
  RealImage? _image;

  ProxyImage(this._filename);

  /// Displays the image
  void displayImage() {
    if (_image == null) {
      _image = RealImage(_filename);
    } else {
      _image!.displayImage();
    }
  }
}

// Test method
void main(List<String> arguments) {
  Graphic image1 = ProxyImage("HiRes_10MB_Photo1");
  Graphic image2 = ProxyImage("HiRes_10MB_Photo2");

  print("--- image1----");
  image1.displayImage(); // loading necessary
  image1.displayImage(); // loading unnecessary
  print("--- image2----");
  image2.displayImage(); // loading necessary
  image2.displayImage(); // loading unnecessary
  print("--- image1----");
  print("image1.displayImage() again  = will display without loading ");
  image1.displayImage(); // loading unnecessary
}

// Output

// --- image1----
// Loading   HiRes_10MB_Photo1
// Displaying HiRes_10MB_Photo1
// --- image2----
// Loading   HiRes_10MB_Photo2
// Displaying HiRes_10MB_Photo2
// --- image1----
// image1.displayImage() again  = will display without loading 
// Displaying HiRes_10MB_Photo1