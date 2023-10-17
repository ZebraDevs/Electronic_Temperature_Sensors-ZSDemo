import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/extensions/list.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/common/styles/theme.dart';
import 'package:zsdemo_app/common/utils/app_utils.dart';
import 'package:zsdemo_app/common/utils/date.dart';
import 'package:zsdemo_app/common/utils/validators.dart';
import 'package:zsdemo_app/components/buttons/footer_actions.dart';
import 'package:zsdemo_app/components/checkboxes/checkbox_stepper.dart';
import 'package:zsdemo_app/components/date_selector.dart';
import 'package:zsdemo_app/components/dialogs/dialog_widget.dart';
import 'package:zsdemo_app/components/error_field_widget.dart';
import 'package:zsdemo_app/components/input_fields/input_fields.dart';
import 'package:zsdemo_app/components/is_loading_widget.dart';
import 'package:zsdemo_app/components/page_controller_builder.dart';
import 'package:zsdemo_app/components/radio/radio_list_tile_stepper.dart';
import 'package:zsdemo_app/components/view_widgets/create_task_section_widget.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/states/task/create_task_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:provider/provider.dart';

part 'create_task_form.dart';
part 'create_task_preview.dart';

const _kDuration = Duration(seconds: 1);
const _kCurve = Curves.linear;

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ScrollController _scrollController;
  late List<Widget> pages;
  final pageController = PageController(initialPage: 0, keepPage: true);
  @override
  void initState() {
    _scrollController = ScrollController();
    pages = [
      CreateTaskForm(formKey: _formKey, controller: _scrollController),
      CreateTaskPreview(controller: pageController),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseWidget<CreateTaskState>(
      state: context.watch<CreateTaskState>(),
      onStateReady: (state) {},
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            automaticallyImplyLeading: false,
            title: Text(Loco.current.createTaskHdlNew),
            actions: [
              IconButton(
                icon: const Icon(ZSIcons.close),
                onPressed: () {
                  _showExitPopUp();
                },
              ),
            ],
          ),
          body: LoadingWidget(
            isLoading: state.busy,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          children: pages,
                        ),
                      ),
                    ),
                  ),
                  CreateTaskFooterView(
                    formKey: _formKey,
                    controller: pageController,
                    curve: Curves.ease,
                    duration: const Duration(seconds: 1),
                    totalSteps: pages.length,
                    executeButtonText: Text(Loco.current.createTaskLblCreate),
                    showExitPopUp: () {
                      _showExitPopUp();
                    },
                  ),
                ].toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showExitPopUp() async {
    await showDialog(
      context: context,
      builder: (context) {
        return ZSDialogWidget(
          title: Text(Loco.current.createTaskExitTitle),
          content: [
            Text(
              Loco.current.createTaskExitDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
          button: TextButton(
            child: Text(Loco.current.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          optionalButton: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _popCreateTaskPage();
            },
            child: Text(Loco.current.yes),
          ),
        );
      },
    );
  }

  void _popCreateTaskPage() {
    Navigator.of(context).pop();
  }

  @override
  bool get wantKeepAlive => true;
}

class CreateTaskFooterView extends StatelessWidget {
  final int totalSteps;
  final PageController controller;
  final Duration duration;
  final Curve curve;
  final GlobalKey<FormState> formKey;
  final Widget executeButtonText;
  final VoidCallback showExitPopUp;
  const CreateTaskFooterView({
    Key? key,
    required this.totalSteps,
    required this.controller,
    required this.duration,
    required this.curve,
    required this.formKey,
    required this.executeButtonText,
    required this.showExitPopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateTaskState>();
    return ZSPageControllerRebuilder(
      controller: controller,
      builder: (context, index) => ZSFooterActions(
        shrinkWrap: true,
        hasTopBorder: true,
        curve: curve,
        duration: duration,
        buttonActions: [
          if (index.round() == 1) ...[
            FooterAction(
              title: Text(Loco.current.createTaskLblBack),
              actionType: FooterActionType.leftBtn,
              isPrimary: false,
              onPressed: (_) {
                hideKeyboard(context);
                formKey.currentState?.validate();
                controller.previousPage(duration: duration, curve: curve);
              },
            ),
            FooterAction(
                title: executeButtonText,
                actionType: FooterActionType.rightBtn,
                onPressed: state.busy
                    ? null
                    : (_) async {
                        hideKeyboard(context);
                        state.createTask(state.taskDetails);
                      }),
          ],
          if (index.round() == 0) ...[
            FooterAction(
              title: Text(Loco.current.cancel),
              actionType: FooterActionType.leftBtn,
              isPrimary: false,
              onPressed: (_) => showExitPopUp(),
            ),
            FooterAction(
                title: Text(Loco.current.continueLabel),
                actionType: FooterActionType.rightBtn,
                onPressed: state.isValid
                    ? (_) {
                        final isValid = formKey.currentState?.validate();
                        if (state.syncForm() == false || isValid != true) return;
                        hideKeyboard(context);
                        final page = controller.page;
                        if (page == null) return;

                        controller.nextPage(duration: duration, curve: curve);
                      }
                    : null),
          ],
        ],
      ),
    );
  }

  bool get hasBack => controller.safePage >= 1;
}
