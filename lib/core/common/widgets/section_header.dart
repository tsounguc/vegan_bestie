import 'package:flutter/material.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.sectionTitle,
    required this.seeAll,
    required this.onSeeAll,
    super.key,
  });

  final String sectionTitle;
  final bool seeAll;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        if (seeAll)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: onSeeAll,
            child: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.theme.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
