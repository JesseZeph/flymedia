import 'package:flutter/material.dart';

class TooltipOverlay extends StatefulWidget {
  final Widget child;

  const TooltipOverlay({Key? key, required this.child}) : super(key: key);

  @override
  _TooltipOverlayState createState() => _TooltipOverlayState();
}

class _TooltipOverlayState extends State<TooltipOverlay> {
  OverlayEntry? _overlayEntry;

  void showTooltip(BuildContext context, Widget tooltip, Offset offset) {
    _overlayEntry = _createOverlayEntry(tooltip, offset);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Widget tooltip, Offset offset) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy,
        left: offset.dx,
        child: tooltip,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
