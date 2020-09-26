import 'package:flutter/material.dart';

class SliverDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Divider(),
    );
  }
}
