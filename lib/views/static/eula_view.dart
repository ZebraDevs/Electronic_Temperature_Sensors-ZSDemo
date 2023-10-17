import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/theme.dart';
import 'package:zsdemo_app/common/utils/app_utils.dart';
import 'package:zsdemo_app/states/static/eula_state.dart';
import 'package:zsdemo_app/views/base_view.dart';

import 'package:provider/provider.dart';

class EulaView extends StatelessWidget {
  const EulaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZSColors.neutralLight00,
      child: BaseWidget<EulaState>(
        state: context.watch<EulaState>(),
        builder: (context, state, child) => Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels > (notification.metrics.maxScrollExtent - 200.0)) {
                state.read = true;
              }
              return true;
            },
            child: Scrollbar(
              controller: state.controller,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: state.controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0, bottom: 24, left: 16),
                      child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.title1!,
                          child: const Text(
                            'End User License Agreement',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                      child: MarkdownBody(
                        styleSheet: MarkdownStyleSheet(
                          p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: ZSColors.secondaryDark,
                              ),
                        ),
                        data: state.eulaData,
                        onTapLink: (x, y, z) {
                          openLink(y!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: state.read ? state.acceptEula : null,
              child: const Text('Accept'),
            ),
          ),
        ),
      ),
    );
  }
}
