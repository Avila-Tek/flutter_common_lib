// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:code_standards/core/constants.dart';
import 'package:flutter/material.dart';

class PokedexError extends StatelessWidget {
  const PokedexError({
    required this.onRetry,
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Error fetching Pokédex',
            style: context.textTheme.titleLarge,
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: Consts.fieldPadding),
            Text(errorMessage!),
          ],
          const SizedBox(height: Consts.sectionPadding),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class PokedexErrorListTile extends StatelessWidget {
  const PokedexErrorListTile({
    required this.onRetry,
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: onRetry,
        label: const Text('Retry'),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}
