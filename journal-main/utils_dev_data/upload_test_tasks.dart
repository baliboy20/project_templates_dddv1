import 'dart:io';

import 'package:journal_macos/src/features/tasks/infrastructure/models/task_vo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'data.configs.dart';



List<TaskVo> testTasks = [
  TaskVo(
    id: '1',
    title: 'Complete Flutter CRUD Screen',
    description: 'Implement the Flutter CRUD screen and integrate with the backend.',
    dueDate: DateTime(2025, 1, 15),
    priority: 1,
    isCompleted: false,
    userId: 'user123',
    projectId: 'proj001',
    category: 'Work',
  ),
  TaskVo(
    id: '2',
    title: 'Prepare Monthly Report',
    description: 'Gather data and prepare the January monthly report.',
    dueDate: DateTime(2025, 1, 20),
    priority: 2,
    isCompleted: false,
    userId: 'user456',
    projectId: 'proj002',
    category: 'Work',
  ),
  TaskVo(
    id: '3',
    title: 'Grocery Shopping',
    description: 'Buy vegetables, fruits, and household essentials.',
    dueDate: DateTime(2025, 1, 14),
    priority: 3,
    isCompleted: false,
    userId: 'user789',
    projectId: null,
    category: 'Personal',
  ),
  TaskVo(
    id: '4',
    title: 'Team Meeting',
    description: 'Discuss project progress and upcoming deadlines.',
    dueDate: DateTime(2025, 1, 16),
    priority: 2,
    isCompleted: false,
    userId: 'user123',
    projectId: 'proj001',
    category: 'Work',
  ),
  TaskVo(
    id: '5',
    title: 'Plan Weekend Getaway',
    description: 'Research destinations and book accommodations.',
    dueDate: DateTime(2025, 1, 18),
    priority: 3,
    isCompleted: false,
    userId: 'user789',
    projectId: null,
    category: 'Personal',
  ),
  TaskVo(
    id: '6',
    title: 'Code Review',
    description: 'Review pull requests and provide feedback.',
    dueDate: DateTime(2025, 1, 13),
    priority: 1,
    isCompleted: true,
    userId: 'user456',
    projectId: 'proj003',
    category: 'Work',
  ),
  TaskVo(
    id: '7',
    title: 'Pay Utility Bills',
    description: 'Pay electricity, water, and internet bills for January.',
    dueDate: DateTime(2025, 1, 15),
    priority: 2,
    isCompleted: false,
    userId: 'user789',
    projectId: null,
    category: 'Personal',
  ),
  TaskVo(
    id: '8',
    title: 'Deploy Backend Service',
    description: 'Deploy the latest version of the Node.js backend service.',
    dueDate: DateTime(2025, 1, 14),
    priority: 1,
    isCompleted: false,
    userId: 'user123',
    projectId: 'proj004',
    category: 'Work',
  ),
  TaskVo(
    id: '9',
    title: 'Update Resume',
    description: 'Revise resume to include recent accomplishments.',
    dueDate: DateTime(2025, 1, 17),
    priority: 2,
    isCompleted: false,
    userId: 'user789',
    projectId: null,
    category: 'Personal',
  ),
  TaskVo(
    id: '10',
    title: 'Conduct Usability Testing',
    description: 'Organize and conduct usability testing for the new mobile app.',
    dueDate: DateTime(2025, 1, 16),
    priority: 1,
    isCompleted: false,
    userId: 'user456',
    projectId: 'proj005',
    category: 'Work',
  ),
];


Future<void> uploadTestTasksToMongo() async {
  final Db db = Db(DataConfigs.dbConnString); // // Replace with your MongoDB URI
  await db.open();


  final collection = db.collection('tasks'); // Replace with your collection name
  collection.deleteMany({});
  try {
    for (var task in testTasks) {
       await collection.insert(task.toJson());
       print('Task ${task.title} uploaded successfully.');
    }
  } catch (e) {
    print('Error uploading snippets: $e');
  } finally {
    await db.close();
  }
}

void main() async {
  await uploadTestTasksToMongo();
  print('done');

}