import 'package:attendance/services/themes.dart';
import 'package:flutter/material.dart';

class RefreshView extends StatelessWidget {
  final bool onLoadMore;
  final Future<void> Function() onRefresh;
  final Widget child;
  final Widget? footer;

  RefreshView({
    this.onLoadMore = false,
    required this.onRefresh,
    this.child = const SizedBox(),
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: blue,
      onRefresh: onRefresh,
      child: Stack(
        children: [
          child,
          Visibility(
            visible: onLoadMore,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              alignment: Alignment.bottomCenter,
              child: footer ?? RefreshProgressIndicator(color: blue),
            ),
          ),
        ],
      ),
    );
  }
}
