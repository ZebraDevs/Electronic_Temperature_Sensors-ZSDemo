import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states/static/zsfinder_state.dart';
import '../views/base_view.dart';

class ZSFinderErrorPage extends StatelessWidget {
  final String errorTitle;
  final String errorDescription;
  final String buttonText;
  final VoidCallback onPress;
  const ZSFinderErrorPage({
    Key? key,
    required this.errorTitle,
    required this.errorDescription,
    required this.buttonText,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double titlefont = MediaQuery.of(context).size.width / 15;
    double subtitlefont = MediaQuery.of(context).size.width / 25;
    double padding = MediaQuery.of(context).size.width / 37;
    return BaseWidget<ZSFinderState>(
        state: context.watch<ZSFinderState>(),
        builder: (context, state, child) {
          return Dialog.fullscreen(
            backgroundColor: Colors.white70,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, padding * 6, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(padding * 1.5),
                  topRight: Radius.circular(padding * 1.5),
                ),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, padding * 3, 0, 0),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Image.asset('assets/files/zsfinder-icon-blue-450x450.png'),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, padding * 3, 0, 0)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(padding * 5, 0, padding * 5, 0),
                        child: Text.rich(
                          TextSpan(
                            text: errorTitle,
                            style: TextStyle(
                              fontSize: titlefont,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, padding * 3, 0, 0)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(padding * 2, 0, padding * 2, 0),
                        child: Text.rich(
                          TextSpan(
                            text: errorDescription,
                            style: TextStyle(
                              fontSize: subtitlefont,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, padding * 3, 0, 0),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(padding * 0.5)),
                        child: Container(
                          color: Colors.blueAccent,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.075,
                          child: TextButton(
                            onPressed: onPress,
                            child: Text.rich(
                              TextSpan(
                                text: buttonText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: subtitlefont,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
