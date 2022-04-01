class CType {
  bool _withVideoTransfer;
  CType(bool withVideoTransfer) : _withVideoTransfer = withVideoTransfer;
  bool isWithVideoTransfer() => _withVideoTransfer;
}

class USB {
  String _version;
  USB(String version) : _version = version;
  String get version => _version;
}
