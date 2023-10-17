import 'package:flutter/material.dart';
import 'package:zsdemo_app/providers/task/create_task_provider.dart';
import 'package:zsdemo_app/views/create_task/create_task_view.dart';


class CreateTaskPage extends MaterialPage {
  static const String routeName = "/create-task-1";

  const CreateTaskPage({
    LocalKey? key,
    required RouteObserver<ModalRoute<dynamic>> observer,
  }) : super(key: key, child: const CreateTaskScreen());
}

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateTaskProvider(
      child: const CreateTaskView(),
    );
  }
}
