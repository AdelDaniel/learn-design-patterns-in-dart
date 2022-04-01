class Mouse {
  bool _withExtraUtilities;
  Mouse(bool withExtraUtilities) : _withExtraUtilities = withExtraUtilities;
  bool isUtfSupport() => _withExtraUtilities;
}
