import 'dart:io';

import 'profile.dart';
import 'social_network_collection.dart';
import 'spammer.dart';

/// Client code
/// Everything comes together here.
void main() {
  print(
    "Please specify social network to target spam tool (default:Facebook):",
  );
  print("1. Facebook");
  print("2. LinkedIn");
  final String choice = stdin.readLineSync()?.toLowerCase().trim() ?? "";

  SocialNetwork network;
  if (choice.contains("2")) {
    network = LinkedIn(testProfiles);
  } else {
    network = Facebook(testProfiles);
  }

  SocialSpammer spammer = SocialSpammer(network);
  spammer.sendSpamToFriends(
    "anna.smith@bing.com",
    "Hey! This is Anna's friend Josh. Can you do me a favor and like this post [link]?",
  );
  spammer.sendSpamToCoworkers(
    "anna.smith@bing.com",
    "Hey! This is Anna's boss Jason. Anna told me you would be interested in [link].",
  );
}

List<Profile> testProfiles = <Profile>[
  Profile(
    "anna.smith@bing.com",
    "Anna Smith",
    [
      "friends:mad_max@ya.com",
      "friends:catwoman@yahoo.com",
      "coworkers:sam@amazon.com"
    ],
  ),
  Profile(
    "mad_max@ya.com",
    "Maximilian",
    ["friends:anna.smith@bing.com", "coworkers:sam@amazon.com"],
  ),
  Profile(
    "bill@microsoft.eu",
    "Billie",
    ["coworkers:avanger@ukr.net"],
  ),
  Profile(
    "avanger@ukr.net",
    "John Day",
    ["coworkers:bill@microsoft.eu"],
  ),
  Profile(
    "sam@amazon.com",
    "Sam Kitting",
    [
      "coworkers:anna.smith@bing.com",
      "coworkers:mad_max@ya.com",
      "friends:catwoman@yahoo.com"
    ],
  ),
  Profile(
    "catwoman@yahoo.com",
    "Liza",
    ["friends:anna.smith@bing.com", "friends:sam@amazon.com"],
  )
];
 


/// Execution result
/// Please specify social network to target spam tool (default:Facebook):
/// 1. Facebook
/// 2. LinkedIn

// Iterating over friends...

// Facebook: Loading 'friends' list of 'anna.smith@bing.com' over the network...
// Facebook: Loading profile 'mad_max@ya.com' over the network...
// Sent message to: 'mad_max@ya.com'. Message body: 'Hey! This is Anna's friend Josh. Can you do me a favor and like this post [link]?'
// Facebook: Loading profile 'catwoman@yahoo.com' over the network...
// Sent message to: 'catwoman@yahoo.com'. Message body: 'Hey! This is Anna's friend Josh. Can you do me a favor and like this post [link]?'

// Iterating over coworkers...

// Facebook: Loading 'coworkers' list of 'anna.smith@bing.com' over the network...
// Facebook: Loading profile 'sam@amazon.com' over the network...
// Sent message to: 'sam@amazon.com'. Message body: 'Hey! This is Anna's boss Jason. Anna told me you would be interested in [link].'
