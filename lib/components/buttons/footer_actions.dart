import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/extensions/list.dart';
import 'package:zsdemo_app/components/checkboxes/checkbox_text.dart';

const kMinBottomInset = 15.0;
const kShortDisplayThreshhold = 750;

class ZSFooterActions extends StatefulWidget {
  final Widget? checkPointTitle;
  final bool? checkPointInitData;
  final List<FooterAction>? buttonActions;
  final Duration duration;
  final Curve curve;
  final bool hasTopBorder;
  final bool shrinkWrap;

  const ZSFooterActions({
    Key? key,
    this.checkPointTitle,
    this.checkPointInitData,
    this.buttonActions,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.hasTopBorder = false,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  State<ZSFooterActions> createState() => _ZSFooterActionsState();
}

class _ZSFooterActionsState extends State<ZSFooterActions> {
  late bool _isCheckBoxChecked;

  @override
  void initState() {
    super.initState();
    _isCheckBoxChecked = widget.checkPointInitData ?? false;
    oldFirst = getAction(FooterActionType.leftBtn, from: widget.buttonActions);
    oldSecond = getAction(FooterActionType.rightBtn, from: widget.buttonActions);
  }

  late FooterAction? oldFirst;
  late FooterAction? oldSecond;

  @override
  void didUpdateWidget(ZSFooterActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldFirst = getAction(FooterActionType.leftBtn, from: oldWidget.buttonActions);
    oldSecond = getAction(FooterActionType.rightBtn, from: oldWidget.buttonActions);
  }

  bool get hasPrev => getAction(FooterActionType.leftBtn, from: widget.buttonActions) != null;
  bool get hasNext => getAction(FooterActionType.rightBtn, from: widget.buttonActions) != null;

  FooterAction? getAction(FooterActionType type, {required List<FooterAction>? from}) {
    return from?.firstWhereOrNull((e) => e.actionType == type);
  }

  @override
  Widget build(BuildContext context) {
    FooterAction? firstAction = getAction(FooterActionType.leftBtn, from: widget.buttonActions);

    FooterAction? secondAction = getAction(FooterActionType.rightBtn, from: widget.buttonActions);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: widget.hasTopBorder ? 1 : 0, color: Theme.of(context).dividerColor),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(bottom: kMinBottomInset, top: kMinBottomInset),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.checkPointTitle != null)
                ZSCheckboxText(
                  title: widget.checkPointTitle,
                  value: _isCheckBoxChecked,
                  onChanged: (value) {
                    setState(() {
                      _isCheckBoxChecked = !_isCheckBoxChecked;
                    });
                  },
                ),
              if (widget.checkPointTitle != null) const SizedBox(height: 56),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (firstAction != null || oldFirst != null)
                      AnimatedOpacity(
                        opacity: hasPrev ? 1 : 0,
                        duration: widget.duration,
                        curve: widget.curve,
                        child: _getButton(firstAction ?? (oldFirst!)),
                      ),
                    const Spacer(),
                    if (secondAction != null || oldSecond != null)
                      AnimatedOpacity(
                        opacity: hasNext ? 1 : 0,
                        duration: widget.duration,
                        curve: widget.curve,
                        child: _getButton(secondAction ?? (oldSecond!)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getButton(FooterAction action) {
    if (action.isPrimary) {
      return ElevatedButton(
        onPressed: action.onPressed != null ? () => action.onPressed!(_isCheckBoxChecked) : null,
        child: action.title,
      );
    } else if (action.isText) {
      return TextButton(
        onPressed: action.onPressed != null ? () => action.onPressed!(_isCheckBoxChecked) : null,
        child: action.title,
      );
    } else {
      return OutlinedButton(
        onPressed: action.onPressed != null ? () => action.onPressed!(_isCheckBoxChecked) : null,
        child: action.title,
      );
    }
  }
}

enum FooterActionType {
  leftBtn,
  rightBtn,
}

class FooterAction {
  Widget title;
  FooterActionType actionType;
  bool isPrimary;
  bool isText;
  Function(bool?)? onPressed;

  FooterAction({
    required this.title,
    required this.actionType,
    this.isPrimary = true,
    this.isText = false,
    this.onPressed,
  });
}
