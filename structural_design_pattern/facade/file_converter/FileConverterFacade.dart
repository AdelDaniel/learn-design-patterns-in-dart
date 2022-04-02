import 'compress.dart';
import 'converter.dart';
import 'file_scanner.dart';
import 'normalizer.dart';

class FileConverterFacade {
  String _file;
  bool _isAudio = true;

  late IFileScanner _fileScanner;
  late INormalizer _normalizer;
  late IConverter _converter;
  late ICompress _fileCompress;

  FileConverterFacade(String filePath) : _file = filePath {
    _detectType();
    _load();
  }

  void _detectType() {
    String fileExtension = _file.split('.').last;
    if (["mp3", "aa", "aac"].contains(fileExtension)) {
      _fileScanner = MP3FileScanner(_file);
      _normalizer = AudioNormalizer();
      _converter = AudioConverter();
      _fileCompress = ZipCompress();
    } else {
      _fileScanner = MP4FileScanner(_file);
      _normalizer = VideoNormalizer();
      _converter = VideoConverter();
      _fileCompress = RarCompress();
      _isAudio = false;
    }
  }

  void _load() {
    if (_fileScanner.scan()) {
      _normalizer.normalize(_file);
    } else {
      // let this be an CorruptedFileException ;
      // but for now we will print just error
      print("error from file Scan");
    }
  }

  convert() {
    if (_isAudio) {
      _converter.convert(
          _file, AudioTypes.AUDIO_MP3.name, AudioTypes.AUDIO_AAC.name);
    } else {
      _converter.convert(
          _file, VideoTypes.AUDIO_MP4.name, VideoTypes.AUDIO_AVI.name);
    }
    _fileCompress.compress(_file);
  }
}
