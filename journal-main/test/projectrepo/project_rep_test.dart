import 'package:journal_macos/src/features/projects/domain/repositories/project_repository.dart';

main() {
  final repository = ProjectRepository();

  repository.getAllProjects().then((projects) {
    projects.forEach((project) {
      print(project.toJson());
    });
  });
 
}