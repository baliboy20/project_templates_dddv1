import 'package:journal_macos/src/features/journals/infrastructure/models/journal_vo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'data.configs.dart';



List<JournalVo> _journals = [
  JournalVo(
    title: 'Mastering Dart Collections',
    categories: ['Dart', 'Collections', 'Programming'],
    body: 'An overview of Dart collections like lists, sets, and maps, with examples.',
    id: '101',
    createdOn: DateTime(2025, 1, 10),
    postedBy: 'John Carter',
  ),
  JournalVo(
    title: 'Flutter Navigation Basics',
    categories: ['Flutter', 'Navigation', 'Programming'],
    body: 'Learn the basics of navigation in Flutter, including Navigator 1.0 and Navigator 2.0.',
    id: '102',
    createdOn: DateTime(2025, 1, 11),
    postedBy: 'Emily Sanders',
  ),
  JournalVo(
    title: 'Optimizing Flutter Apps',
    categories: ['Flutter', 'Performance', 'Programming'],
    body: 'Tips and tricks to optimize Flutter apps for better performance.',
    id: '103',
    createdOn: DateTime(2025, 1, 12),
    postedBy: 'Alice Morgan',
  ),
  JournalVo(
    title: 'Introduction to REST APIs',
    categories: ['APIs', 'Web Development', 'Backend'],
    body: 'Understanding REST APIs and how to interact with them using HTTP methods.',
    id: '104',
    createdOn: DateTime(2025, 1, 13),
    postedBy: 'Michael Stone',
  ),
  JournalVo(
    title: 'State Management with Provider',
    categories: ['Flutter', 'State Management', 'Provider'],
    body: 'A beginner’s guide to managing state in Flutter using Provider.',
    id: '105',
    createdOn: DateTime(2025, 1, 14),
    postedBy: 'Sophia Brown',
  ),
  JournalVo(
    title: 'Building Reusable Widgets in Flutter',
    categories: ['Flutter', 'UI', 'Widgets'],
    body: 'Learn how to create and use reusable widgets to maintain code cleanliness.',
    id: '106',
    createdOn: DateTime(2025, 1, 15),
    postedBy: 'David Taylor',
  ),
  JournalVo(
    title: 'Dart Streams Explained',
    categories: ['Dart', 'Streams', 'Programming'],
    body: 'Understanding Dart streams for asynchronous data handling.',
    id: '107',
    createdOn: DateTime(2025, 1, 16),
    postedBy: 'Rachel Adams',
  ),
  JournalVo(
    title: 'Deploying Node.js Apps',
    categories: ['Node.js', 'Deployment', 'Backend'],
    body: 'A guide to deploying Node.js applications to cloud services.',
    id: '108',
    createdOn: DateTime(2025, 1, 17),
    postedBy: 'Christopher Walker',
  ),
  JournalVo(
    title: 'Flutter Animations 101',
    categories: ['Flutter', 'Animations', 'UI'],
    body: 'Get started with animations in Flutter using the AnimationController.',
    id: '109',
    createdOn: DateTime(2025, 1, 18),
    postedBy: 'Sophia Johnson',
  ),
  JournalVo(
    title: 'Introduction to Unit Testing',
    categories: ['Testing', 'Dart', 'Programming'],
    body: 'An introduction to writing unit tests in Dart and Flutter applications.',
    id: '110',
    createdOn: DateTime(2025, 1, 19),
    postedBy: 'Daniel Clark',
  ),
];



Future<void> uploadTestJournalsToMongo() async {
  final Db db = Db(DataConfigs.dbConnString); // Replace with your MongoDB URI
  await db.open();

  final collection = db.collection('journals'); // Replace with your collection name
  await collection.deleteMany({});

  try {
    for (var journal in _journals) {
      final  result =  await collection.insert(journal.toJson());
       print('\nJounal ${result} uploaded successfully.');
    }
  } catch (e) {
    print('Error uploading journal: $e');
  } finally {
    await db.close();
  }
}

void main() async {
  await uploadTestJournalsToMongo();
  print('done');

}