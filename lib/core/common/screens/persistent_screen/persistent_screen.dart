import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/tab_navigator.dart';

class PersistentScreen extends StatefulWidget {
  const PersistentScreen({
    this.body,
    super.key,
  });

  final Widget? body;

  @override
  State<PersistentScreen> createState() => _PersistentScreenState();
}

class _PersistentScreenState extends State<PersistentScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => false;
}
