import 'package:code_standards/core/constants.dart';
import 'package:flutter/material.dart';

class AvilaSnackBarChild extends StatelessWidget {
  const AvilaSnackBarChild({
    this.title,
    this.description,
    super.key,
  }) : assert(
          title != null || description != null,
          'Either title or description must be provided',
        );

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.textTheme.labelLarge?.copyWith(color: Colors.white),
          ),
        if (description != null)
          Text(
            description!,
            style: context.textTheme.labelMedium?.copyWith(color: Colors.white),
          ),
      ],
    );
  }
}
