
import 'package:mongo_dart/mongo_dart.dart';

abstract class Phrase  {
  final String french;
  final String english;
  final String breakdown;
  final String source;
  final List<String> categories;
  final DateTime updatedOn;
  final String themes;
  final String? id;

  Phrase({
    required this.french,
    required this.english,
    required this.breakdown,
    required this.source,
    required this.categories,
    required this.updatedOn,
    required this.themes,
    required this.id,
  });
}

class PhraseVo  extends Phrase {
  final String french;
  final String english;
  final String breakdown;
  final String source;
  final List<String> categories;
  final DateTime updatedOn;
  final String themes;
  final String? id;


  PhraseVo({
    required this.french,
    required this.english,
    required this.breakdown,
    required this.source,
    required this.categories,
    required this.updatedOn,
    required this.themes,
    required this.id,
  }) : super(
    french: french,
    english: english,
    breakdown: breakdown,
    source: source,
    categories: categories,
    updatedOn: updatedOn,
    themes: themes,
    id: id,
  );



  @override
  List<Object?> get props => [
    id,
  ];

  // bool sorter(PhraseVo other, [bool ascendingOrder = true]) {
  //   return ascendingOrder
  //       ? this.updatedOn.isBefore(other.updatedOn)
  //       : this.updatedOn.isAfter(other.updatedOn);
  // }

  @override
  bool? get stringify => true;


  Map<String, dynamic> toJson(PhraseVo phrase) {
    final map = {
      'french': phrase.french,
      'english': phrase.english,
      'breakdown': phrase.breakdown,
      'source': phrase.source,
      'categories': phrase.categories,
      'updatedOn': phrase.updatedOn.toIso8601String(),
      'themes': phrase.themes,
      'id': phrase.id,
    };
    return (map);
  }


}






List<PhraseVo> testDataPhraseVo = [
  PhraseVo(
    french: "Bonjour",
    english: "Hello",
    breakdown: "Bon (Good) + Jour (Day)",
    source: "Common greeting",
    categories: ["Greeting"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Conversation",
    id: "1",
  ),
  PhraseVo(
    french: "Merci",
    english: "Thank you",
    breakdown: "N/A",
    source: "Common courtesy",
    categories: ["Politeness"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Etiquette",
    id: "2",
  ),
  PhraseVo(
    french: "Comment ça va?",
    english: "How are you?",
    breakdown: "Comment (How) + ça (it) + va (goes)",
    source: "Casual greeting",
    categories: ["Greeting"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Conversation",
    id: "3",
  ),
  PhraseVo(
    french: "Excusez-moi",
    english: "Excuse me",
    breakdown: "Excuser (to excuse) + moi (me)",
    source: "Politeness",
    categories: ["Apology"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Etiquette",
    id: "4",
  ),
  PhraseVo(
    french: "S'il vous plaît",
    english: "Please",
    breakdown: "Si (If) + il (it) + vous (you) + plaît (pleases)",
    source: "Politeness",
    categories: ["Manners"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Etiquette",
    id: "5",
  ),
  PhraseVo(
    french: "Je t'aime",
    english: "I love you",
    breakdown: "Je (I) + t' (you) + aime (love)",
    source: "Romantic",
    categories: ["Love"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Relationships",
    id: "6",
  ),
  PhraseVo(
    french: "Où sont les toilettes?",
    english: "Where are the toilets?",
    breakdown: "Où (Where) + sont (are) + les (the) + toilettes (toilets)",
    source: "Travel",
    categories: ["Travel"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Tourism",
    id: "7",
  ),
  PhraseVo(
    french: "Parlez-vous anglais?",
    english: "Do you speak English?",
    breakdown: "Parlez (Speak) + vous (you) + anglais (English)?",
    source: "Travel",
    categories: ["Communication"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Language",
    id: "8",
  ),
  PhraseVo(
    french: "Je suis désolé(e)",
    english: "I am sorry",
    breakdown: "Je (I) + suis (am) + désolé(e) (sorry)",
    source: "Apology",
    categories: ["Apology"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Manners",
    id: "9",
  ),
  PhraseVo(
    french: "Quelle heure est-il?",
    english: "What time is it?",
    breakdown: "Quelle (What) + heure (hour) + est-il (is it)?",
    source: "Common phrase",
    categories: ["Time"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Conversation",
    id: "10",
  ),
  PhraseVo(
    french: "J'ai faim",
    english: "I'm hungry",
    breakdown: "J' (I) + ai (have) + faim (hunger)",
    source: "Common need",
    categories: ["Food"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Needs",
    id: "11",
  ),
  PhraseVo(
    french: "J'ai soif",
    english: "I'm thirsty",
    breakdown: "J' (I) + ai (have) + soif (thirst)",
    source: "Common need",
    categories: ["Food"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Needs",
    id: "12",
  ),
  PhraseVo(
    french: "Pouvez-vous m'aider?",
    english: "Can you help me?",
    breakdown: "Pouvez (Can) + vous (you) + m' (me) + aider (help)?",
    source: "Request",
    categories: ["Assistance"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Help",
    id: "13",
  ),
  PhraseVo(
    french: "Combien ça coûte?",
    english: "How much does it cost?",
    breakdown: "Combien (How much) + ça (it) + coûte (costs)?",
    source: "Shopping",
    categories: ["Shopping"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Finance",
    id: "14",
  ),
  PhraseVo(
    french: "Je ne comprends pas",
    english: "I don't understand",
    breakdown: "Je (I) + ne (not) + comprends (understand) + pas (not)",
    source: "Communication",
    categories: ["Language"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Learning",
    id: "15",
  ),
  PhraseVo(
    french: "Où est la gare?",
    english: "Where is the train station?",
    breakdown: "Où (Where) + est (is) + la (the) + gare (train station)?",
    source: "Travel",
    categories: ["Transportation"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Tourism",
    id: "16",
  ),
  PhraseVo(
    french: "Bonne nuit",
    english: "Good night",
    breakdown: "Bonne (Good) + nuit (Night)",
    source: "Common phrase",
    categories: ["Greeting"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Conversation",
    id: "17",
  ),
  PhraseVo(
    french: "Enchanté(e)",
    english: "Nice to meet you",
    breakdown: "Enchanté(e) (Delighted)",
    source: "Introduction",
    categories: ["Social"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Networking",
    id: "18",
  ),
  PhraseVo(
    french: "À bientôt",
    english: "See you soon",
    breakdown: "À (To) + bientôt (soon)",
    source: "Farewell",
    categories: ["Goodbye"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Conversation",
    id: "19",
  ),
  PhraseVo(
    french: "Bonne journée",
    english: "Have a nice day",
    breakdown: "Bonne (Good) + journée (Day)",
    source: "Common phrase",
    categories: ["Greeting"],
    updatedOn: DateTime(2024, 2, 1),
    themes: "Daily Conversation",
    id: "20",
  ),
];

Future<void> uploadTestProjectsToMongo() async {
  final Db db = Db("mongodb://localhost:27017/journal"); //ace with your MongoDB URI
  await db.open();

  final collection = db.collection('phrases'); // Replace with your collection name
  collection.deleteMany({});
  try {
    for (var phrase in testDataPhraseVo) {


      await collection.insert(phrase.toJson(phrase));

    }
  } catch (e) {
    print('Error uploading projects: $e');
  } finally {
    await db.close();
  }
}

void main() async {
  await uploadTestProjectsToMongo();
  print('done');
}
