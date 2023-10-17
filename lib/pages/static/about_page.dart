import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/views/static/about_view.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/about';
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Loco.current.menuAbout,
          style: const TextStyle(color: ZSColors.neutralLight00),
        ),
      ),
      body: const AboutView(),
    );
  }
}
