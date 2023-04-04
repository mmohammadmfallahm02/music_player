import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.themeData,
    required this.title,
    this.action = 'View More',
  }) : super(key: key);

  final ThemeData themeData;
  final String title;
  final String action;

  Text _buildActionWidget() {
    return Text(
      action,
      style: themeData.textTheme.bodyLarge!.copyWith(
        color: Colors.white,
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      title,
      style: themeData.textTheme.headline6!
          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitleWidget(),
        _buildActionWidget(),
      ],
    );
  }
}
