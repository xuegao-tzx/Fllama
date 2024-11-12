import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class IconSwitch extends StatefulWidget {
  const IconSwitch({super.key});

  @override
  _IconSwitchState createState() => _IconSwitchState();
}

class _IconSwitchState extends State<IconSwitch> {
  bool _isDownloadIcon = true;

  @override
  void initState() {
    super.initState();
    // 在2秒后切换图标
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _isDownloadIcon = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _isDownloadIcon
            ? const Icon(
                Symbols.download,
                size: 26,
                key: ValueKey('download'),
              )
            : const Icon(
                Symbols.delete_forever,
                size: 26,
                key: ValueKey('delete'),
              ),
      ),
    );
  }
}
