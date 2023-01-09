import 'celebrity_subject.dart';
import 'followers_observer.dart';

void main() {
  Celebrity amirkhan = new Celebrity("Amirkhan");
  Celebrity selenaGomez = new Celebrity("Selena Gomez");

  Follower amar = new Follower("Amar");
  Follower juhi = new Follower("Juhi");
  Follower urja = new Follower("Urja");
  Follower malay = new Follower("Malay");
  Follower ankit = new Follower("Ankit");
  Follower harsh = new Follower("Harsh");

  amirkhan.register(amar);
  amirkhan.register(juhi);
  amirkhan.register(urja);

  selenaGomez.register(malay);
  selenaGomez.register(ankit);
  selenaGomez.register(harsh);

  amirkhan
      .tweet("Hey guys, came across this interesting trailer, check it out.");
  selenaGomez.tweet("Good Morning..!!");

  amirkhan.unregister(juhi);

  amirkhan.tweet("Teaser of Secret Superstar has been released..!!");
}
