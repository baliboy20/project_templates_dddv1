import 'package:journal_macos/src/features/projects/infrastructure/models/project_vo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'data.configs.dart';

const List<ProjectVo> testProjectsVo = [
  ProjectVo(
    projectName: 'Project Alpha',
    description: 'Description for Project Alpha',
    snippetsId: ['snippet1', 'snippet2'],
    taskId: ['task1', 'task2'],
    journalId: ['journal1'],
    projectStatus: 'Active',
    projectPath: '/projects/alpha',

  ),
  ProjectVo(
    projectName: 'Project Beta',
    description: 'Description for Project Beta',
    snippetsId: ['snippet3'],
    taskId: ['task3', 'task4'],
    journalId: ['journal2'],
    projectStatus: 'Completed',
    projectPath: '/projects/beta',

  ),
  ProjectVo(
    projectName: 'Project Gamma',
    description: 'Description for Project Gamma',
    snippetsId: ['snippet5'],
    taskId: ['task6'],
    journalId: ['journal3', 'journal4'],
    projectStatus: 'On Hold',
    projectPath: '/projects/gamma',

  ),
  ProjectVo(
    projectName: 'Project Delta',
    description: 'Description for Project Delta',
    snippetsId: ['snippet7', 'snippet8', 'snippet9'],
    taskId: ['task8'],
    journalId: [],
    projectStatus: 'Active',
    projectPath: '/projects/delta',

  ),
  ProjectVo(
    projectName: 'Project Epsilon',
    description: 'Description for Project Epsilon',
    snippetsId: ['snippet10'],
    taskId: [],
    journalId: ['journal5'],
    projectStatus: 'Completed',
    projectPath: '/projects/epsilon',

  ),
  ProjectVo(
    projectName: 'Project Zeta',
    description: 'Description for Project Zeta',
    snippetsId: [],
    taskId: ['task11', 'task12'],
    journalId: [],
    projectStatus: 'On Hold',
    projectPath: '/projects/zeta',

  ),
  ProjectVo(
    projectName: 'Project Eta',
    description: 'Description for Project Eta',
    snippetsId: ['snippet12', 'snippet13'],
    taskId: [],
    journalId: ['journal6', 'journal7'],
    projectStatus: 'Active',
    projectPath: '/projects/eta',

  ),
  ProjectVo(
    projectName: 'Project Theta',
    description: 'Description for Project Theta',
    snippetsId: [],
    taskId: ['task13'],
    journalId: ['journal8'],
    projectStatus: 'Completed',
    projectPath: '/projects/theta',

  ),
  ProjectVo(
    projectName: 'Project Iota',
    description: 'Description for Project Iota',
    snippetsId: ['snippet15'],
    taskId: [],
    journalId: [],
    projectStatus: 'Active',
    projectPath: '/projects/iota',

  ),
  ProjectVo(
    projectName: 'Project Kappa',
    description: 'Description for Project Kappa',
    snippetsId: ['snippet16', 'snippet17'],
    taskId: ['task15'],
    journalId: ['journal9', 'journal10'],
    projectStatus: 'On Hold',
    projectPath: '/projects/kappa',

  ),
  ProjectVo(
    projectName: 'Project Lambda',
    description: 'Description for Project Lambda',
    snippetsId: ['snippet18'],
    taskId: [],
    journalId: [],
    projectStatus: 'Active',
    projectPath: '/projects/lambda',

  ),
  ProjectVo(
    projectName: 'Project Mu',
    description: 'Description for Project Mu',
    snippetsId: ['snippet19'],
    taskId: ['task16', 'task17'],
    journalId: [],
    projectStatus: 'Completed',
    projectPath: '/projects/mu',

  ),
  ProjectVo(
    projectName: 'Project Nu',
    description: 'Description for Project Nu',
    snippetsId: [],
    taskId: ['task18'],
    journalId: ['journal11'],
    projectStatus: 'Active',
    projectPath: '/projects/nu',

  ),
  ProjectVo(
    projectName: 'Project Xi',
    description: 'Description for Project Xi',
    snippetsId: ['snippet20', 'snippet21'],
    taskId: [],
    journalId: [],
    projectStatus: 'On Hold',
    projectPath: '/projects/xi',

  ),
  ProjectVo(
    projectName: 'Project Omicron',
    description: 'Description for Project Omicron',
    snippetsId: [],
    taskId: ['task20'],
    journalId: ['journal12'],
    projectStatus: 'Completed',
    projectPath: '/projects/omicron',

  ),
  ProjectVo(
    projectName: 'Project Pi',
    description: 'Description for Project Pi',
    snippetsId: [],
    taskId: [],
    journalId: ['journal13', 'journal14'],
    projectStatus: 'Active',
    projectPath: '/projects/pi',

  ),
  ProjectVo(
    projectName: 'Project Rho',
    description: 'Description for Project Rho',
    snippetsId: ['snippet22'],
    taskId: ['task21', 'task22'],
    journalId: [],
    projectStatus: 'On Hold',
    projectPath: '/projects/rho',

  ),
  ProjectVo(
    projectName: 'Project Sigma',
    description: 'Description for Project Sigma',
    snippetsId: [],
    taskId: [],
    journalId: ['journal15'],
    projectStatus: 'Completed',
    projectPath: '/projects/sigma',

  ),
  ProjectVo(
    projectName: 'Project Tau',
    description: 'Description for Project Tau',
    snippetsId: ['snippet23'],
    taskId: ['task23'],
    journalId: [],
    projectStatus: 'Active',
    projectPath: '/projects/tau',

  ),
  ProjectVo(
    projectName: 'Project Upsilon',
    description: 'Description for Project Upsilon',
    snippetsId: ['snippet24', 'snippet25'],
    taskId: [],
    journalId: ['journal16'],
    projectStatus: 'Completed',
    projectPath: '/projects/upsilon',
  ),
];


Future<void> uploadTestProjectsToMongo() async {
  final Db db = Db(DataConfigs.dbConnString); //ace with your MongoDB URI
  await db.open();

  final collection = db.collection('projects'); // Replace with your collection name
collection.deleteMany({});
  try {
    for (var project in testProjectsVo) {


       await collection.insert(project.toJson());

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