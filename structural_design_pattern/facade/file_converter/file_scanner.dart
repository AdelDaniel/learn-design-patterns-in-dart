import 'dart:math' as math;

abstract class IFileScanner {
  String file;
  IFileScanner(String this.file);
  bool scan();
}

class MP3FileScanner extends IFileScanner {
  MP3FileScanner(String file) : super(file);

  @override
  bool scan() => math.Random().nextInt(10) > 5;
}

class MP4FileScanner extends IFileScanner {
  MP4FileScanner(String file) : super(file);
  // Do a lot of stuff here then return the file status
  @override
  bool scan() => math.Random().nextInt(10) > 5;
}
