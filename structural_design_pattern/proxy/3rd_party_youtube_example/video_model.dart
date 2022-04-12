class Video {
  final String id;
  final String title;
  final String data;

  const Video({
    required this.id,
    required this.title,
    this.data = "Random video.",
  });
}
