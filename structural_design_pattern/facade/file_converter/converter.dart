abstract class IConverter {
  void convert(String fileName, String fromType, String toType);
}

enum AudioTypes { AUDIO_MP3, AUDIO_AA, AUDIO_AAC }
enum VideoTypes { AUDIO_MP4, AUDIO_AVI, AUDIO_FLV }

class AudioConverter implements IConverter {
  void convert(String fileName, String fromType, String toType) => print(
      "I am converting audio file $fileName from $fromType to $toType \n");
}

class VideoConverter implements IConverter {
  void convert(String fileName, String fromType, String toType) =>
      print("I am converting the file $fileName from $fromType to $toType \n");
}
