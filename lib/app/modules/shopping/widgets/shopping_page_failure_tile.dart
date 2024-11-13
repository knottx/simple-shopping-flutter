import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_shopping/generated/app_localizations.dart';

class ShoppingPageFailureTile extends StatelessWidget {
  final VoidCallback onTapRefresh;

  const ShoppingPageFailureTile({
    super.key,
    required this.onTapRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.xmark_circle,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).errorSomethingWentWrong,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: onTapRefresh,
            child: Text(
              AppLocalizations.of(context).commonRefresh,
            ),
          ),
        ],
      ),
    );
  }
}
