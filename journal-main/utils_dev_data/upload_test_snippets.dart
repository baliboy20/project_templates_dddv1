import 'package:journal_macos/src/features/snippets/infrastructure/models/snippet_vo.dart';
import 'package:journal_macos/src/features/snippets/infrastructure/models/snippet_vo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'data.configs.dart';


 
final List<SnippetVo> testProjectsVo = [
  SnippetVo(
    title: 'Flutter State Management',
    categories: ['Flutter', 'State Management', 'Programming'],
    body: 'Exploring state management techniques in Flutter, including Provider, Riverpod, and Bloc.',
    id: '1',
    createdOn: DateTime(2025, 1, 10),
    postedBy: 'John Doe',
  ),
  SnippetVo(
    title: 'Understanding Async/Await in Dart',
    categories: ['Dart', 'Async', 'Programming'],
    body: 'A deep dive into asynchronous programming in Dart using async and await.',
    id: '2',
    createdOn: DateTime(2025, 1, 11),
    postedBy: 'Jane Smith',
  ),
  SnippetVo(
    title: 'Node.js with MongoDB',
    categories: ['Node.js', 'Database', 'Backend'],
    body: 'Connecting Node.js applications to MongoDB and performing CRUD operations.',
    id: '3',
    createdOn: DateTime(2025, 1, 12),
    postedBy: 'Alex Johnson',
  ),
  SnippetVo(
    title: 'Building REST APIs',
    categories: ['REST API', 'Backend', 'Web Development'],
    body: 'Step-by-step guide to building RESTful APIs using Express.js.',
    id: '4',
    createdOn: DateTime(2025, 1, 13),
    postedBy: 'Emily Davis',
  ),
  SnippetVo(
    title: 'Introduction to Flutter Widgets',
    categories: ['Flutter', 'UI', 'Programming'],
    body: 'A beginner-friendly guide to understanding and using widgets in Flutter.',
    id: '5',
    createdOn: DateTime(2025, 1, 14),
    postedBy: 'Chris Wilson',
  ),
  SnippetVo(
    title: 'Effective Debugging in Flutter',
    categories: ['Flutter', 'Debugging', 'Programming'],
    body: 'Tips and tools for debugging Flutter applications effectively.',
    id: '6',
    createdOn: DateTime(2025, 1, 15),
    postedBy: 'Sarah Lee',
  ),
  SnippetVo(
    title: 'Secure User Authentication',
    categories: ['Security', 'Backend', 'Authentication'],
    body: 'Implementing secure user authentication in web applications.',
    id: '7',
    createdOn: DateTime(2025, 1, 16),
    postedBy: 'Michael Brown',
  ),
  SnippetVo(
    title: 'Deploying Flutter Web',
    categories: ['Flutter', 'Web Development', 'Deployment'],
    body: 'Steps to deploy Flutter web applications to hosting platforms.',
    id: '8',
    createdOn: DateTime(2025, 1, 17),
    postedBy: 'Anna White',
  ),
  SnippetVo(
    title: 'Unit Testing in Dart',
    categories: ['Dart', 'Testing', 'Programming'],
    body: 'Guide to writing and running unit tests in Dart applications.',
    id: '9',
    createdOn: DateTime(2025, 1, 18),
    postedBy: 'Daniel Green',
  ),
  SnippetVo(
    title: 'Responsive Design in Flutter',
    categories: ['Flutter', 'UI', 'Responsive Design'],
    body: 'Creating responsive designs in Flutter for multiple screen sizes.',
    id: '10',
    createdOn: DateTime(2025, 1, 19),
    postedBy: 'Laura Martin',
  ),
];

Future<void> uploadTestSnippetsToMongo() async {
  final Db db = Db(DataConfigs.dbConnString); //
    await db.open();

  final collection = db.collection('snippets');
  collection.drop();// Replace with your collection name

  try {
    for (var snippet in testProjectsVo) {


       await collection.insert(snippet.toJson());

    }
  } catch (e) {
    print('Error uploading snippets: $e');
  } finally {
    await db.close();
  }
}

void main() async {
  await uploadTestSnippetsToMongo();
  print('done');
}