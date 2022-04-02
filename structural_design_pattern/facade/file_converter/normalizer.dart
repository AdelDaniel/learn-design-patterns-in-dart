abstract class INormalizer {
  void normalize(String fileName);
}

class AudioNormalizer implements INormalizer {
  @override
  void normalize(String fileName) => print(
      "I am normalizing the file $fileName due to some data corruption\n");
}

class VideoNormalizer implements INormalizer {
  @override
  void normalize(String fileName) => print(
      "I am normalizing the video $fileName due to some data corruption\n");
}
