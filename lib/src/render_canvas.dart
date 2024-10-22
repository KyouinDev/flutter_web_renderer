import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'package:web_renderer/web_renderer.dart';

class RenderCanvas extends StatefulWidget {
  final Webserver webserver;

  final ThemeData? theme;

  const RenderCanvas({
    required this.webserver,
    this.theme,
    super.key,
  });

  @override
  State<RenderCanvas> createState() => _RenderCanvasState();
}

class _RenderCanvasState extends State<RenderCanvas> {
  Widgetable? widgetable;

  @override
  void initState() {
    super.initState();

    widget.webserver.stateSetter = (widgetable) {
      setState(() => this.widgetable = widgetable);
    };
  }

  @override
  Widget build(BuildContext context) {
    if (widgetable == null) {
      return Container();
    }

    return RepaintBoundary(
      key: widget.webserver.canvasKey,
      child: MaterialApp(
        title: 'Renderer',
        theme: widget.theme,
        home: Material(
          type: MaterialType.transparency,
          child: ColoredBox(
            color: Colors.transparent,
            child: Screenshot(
              controller: widget.webserver.screenshotController,
              child: widgetable!.asWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
