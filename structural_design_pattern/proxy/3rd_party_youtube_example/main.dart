import 'video_model.dart';

int lineNum = 0;

abstract class ThirdPartyYouTubeLib {
  Map<String, Video> popularVideos();
  Video getVideo(String videoId);
}

class ThirdPartyYouTubeClass implements ThirdPartyYouTubeLib {
  @override
  Map<String, Video> popularVideos() {
    _connectToServer("http://www.youtube.com");
    return _getPopularVideos();
  }

  @override
  Video getVideo(String videoId) {
    _connectToServer("http://www.youtube.com/$videoId");
    return _getSomeVideo(videoId);
  }

  // -----------------------------------------------------------------------
  // Fake methods to simulate network activity.
  // They as slow as a real life.

  void _experienceNetworkLatency() {
    // int randomLatency = 5 + (Random().nextInt(10) * 6);
    int randomLatency = 10;
    for (int i = 0; i < randomLatency; i++) {
      try {
        Future.delayed(Duration(milliseconds: 100));
      } catch (ex) {
        print(ex);
      }
    }
  }

  void _connectToServer(String server) {
    print("${++lineNum}: Connecting to  $server ... ");
    _experienceNetworkLatency();
    print("${++lineNum}: Connected! ");
  }

  Map<String, Video> _getPopularVideos() {
    print("${++lineNum}: Downloading popular Videos... ");
    _experienceNetworkLatency();
    _experienceNetworkLatency();
    Map<String, Video> map = Map<String, Video>();
    map["catzzzzzzzzz"] = Video(id: "sadgahasgdas", title: "Catzzzz.avi");
    map["dancesvideoo"] = Video(id: "asdfas3ffasd", title: "Dancing video.mpq");
    print("${++lineNum}: Done!");
    return map;
  }

  Video _getSomeVideo(String videoId) {
    print("${++lineNum}: Downloading video... ");

    _experienceNetworkLatency();
    Video video = Video(id: videoId, title: "Some video title");

    print("${++lineNum}: Done!");
    return video;
  }
}

class YouTubeCacheProxy implements ThirdPartyYouTubeLib {
  ThirdPartyYouTubeLib _youtubeService = ThirdPartyYouTubeClass();
  Map<String, Video> _cachePopular = Map<String, Video>();
  Map<String, Video> _cacheAll = Map<String, Video>();

  YouTubeCacheProxy();

  @override
  Map<String, Video> popularVideos() {
    if (_cachePopular.isEmpty) {
      _cachePopular = _youtubeService.popularVideos();
    } else {
      print("${++lineNum}: Retrieved list from cache.");
    }
    return _cachePopular;
  }

  @override
  Video getVideo(String videoId) {
    Video? video = _cacheAll[videoId];
    if (video == null) {
      video = _youtubeService.getVideo(videoId);
      _cacheAll[videoId] = video;
    } else {
      print("${++lineNum}: Retrieved video ' $videoId ' from cache.");
    }
    return video;
  }

  void reset() {
    _cachePopular.clear();
    _cacheAll.clear();
  }
}

class YouTubeDownloader {
  ThirdPartyYouTubeLib _api;

  YouTubeDownloader(ThirdPartyYouTubeLib api) : _api = api;

  void renderVideoPage(String videoId) {
    Video video = _api.getVideo(videoId);
    print("${++lineNum}: -------------------------------");
    print("${++lineNum}: Video page (imagine fancy HTML)");
    print(
        "${++lineNum}: ID: ${video.id} && Title: ${video.title} && Video: ${video.data}");
    print("${++lineNum}: -------------------------------");
  }

  void renderPopularVideos() {
    Map<String, Video> map = _api.popularVideos();
    print("${++lineNum}: -------------------------------");
    print("${++lineNum}: Most popular videos on YouTube (imagine fancy HTML)");

    for (Video video in map.values) {
      print("${++lineNum}: ID:  ${video.id}  / Title:  ${video.title}");
    }
    print("${++lineNum}: -------------------------------");
  }
}

void main() {
  // without proxy
  YouTubeDownloader naiveDownloader =
      YouTubeDownloader(ThirdPartyYouTubeClass());
  // with proxy
  YouTubeDownloader smartDownloader = YouTubeDownloader(YouTubeCacheProxy());

  int naive = test(naiveDownloader);
  print(
      "${++lineNum}: -------------------------Proxy Added-------------------------");
  int smart = test(smartDownloader);
  print("${++lineNum}: Time elapsed without proxy = naive:  $naive ms");
  print("${++lineNum}: Time elapsed with proxy = smart:  $smart ms");
  print(
      "${++lineNum}: Time saved by caching proxy:  ($naive - $smart= ${naive - smart}) ms");
}

int test(YouTubeDownloader downloader) {
  int startTime = DateTime.now().millisecond;

  // User behavior in our app:
  downloader.renderPopularVideos();
  downloader.renderVideoPage("catzzzzzzzzz");
  downloader.renderPopularVideos();
  downloader.renderVideoPage("dancesvideoo");
  // Users might visit the same page quite often.
  downloader.renderVideoPage("catzzzzzzzzz");
  downloader.renderVideoPage("someothervid");

  int estimatedTime = DateTime.now().millisecond - startTime;
  return estimatedTime;
}
