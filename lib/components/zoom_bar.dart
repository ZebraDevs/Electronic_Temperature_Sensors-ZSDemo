import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class ZSZoomBar extends StatefulWidget {
  final List<double> zooms;
  final int selectedZoom;
  final void Function(double) onZoomSelected;
  const ZSZoomBar({
    Key? key,
    required this.zooms,
    required this.selectedZoom,
    required this.onZoomSelected,
  }) : super(key: key);

  @override
  State<ZSZoomBar> createState() => _ZSZoomBarState();
}

class _ZSZoomBarState extends State<ZSZoomBar> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = _QuickTabController(vsync: this, length: widget.zooms.length);
    controller.index = widget.selectedZoom;
  }

  @override
  void didUpdateWidget(ZSZoomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.zooms.length != widget.zooms.length) {
      controller = _QuickTabController(vsync: this, length: widget.zooms.length);
    }
    if (oldWidget.selectedZoom != widget.selectedZoom) {
      controller.index = widget.selectedZoom;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.selectedZoom >= 0 && widget.selectedZoom < widget.zooms.length, 'selectedZoom not in range of zooms');
    const primaryColor = ZSColors.primary;
    const onPrimaryColor = ZSColors.neutralLight20;
    final borderRadius = BorderRadius.circular(99);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            width: 2,
            color: onPrimaryColor,
            // style: BorderStyle,
          ),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: onPrimaryColor,
          ),
          child: TabBar(
            controller: controller,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              // shape: BoxShape.circle,
              color: primaryColor,
            ),
            labelColor: onPrimaryColor,
            unselectedLabelColor: primaryColor,
            onTap: (index) => widget.onZoomSelected(widget.zooms[index]),
            tabs: [
              for (final zoom in widget.zooms)
                SizedBox(
                  width: 20,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Center(
                      child: Text(
                        formatZoom(zoom) +
                            () {
                              if (widget.zooms.indexOf(zoom) == widget.selectedZoom) return '×';
                              return '';
                            }(),
                        // style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String formatZoom(double zoom) {
    return zoom.toStringAsFixed(zoom.truncateToDouble() == zoom ? 0 : 1);
  }
}

class _QuickTabController extends TabController {
  _QuickTabController({int initialIndex = 0, required int length, required TickerProvider vsync})
      : super(initialIndex: initialIndex, length: length, vsync: vsync);

  @override
  void animateTo(int value, {Duration? duration = const Duration(milliseconds: 100), Curve curve = Curves.ease}) {
    super.animateTo(value, duration: duration, curve: curve);
  }
}
