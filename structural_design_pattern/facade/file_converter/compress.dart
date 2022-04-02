abstract class ICompress {
  void compress(String fileName);
}

class RarCompress implements ICompress {
  @override
  void compress(String fileName) =>
      print("File has been compressed to a rar file\n");
}

class ZipCompress implements ICompress {
  @override
  void compress(String fileName) =>
      print("File has been compressed to a zip file\n");
}
