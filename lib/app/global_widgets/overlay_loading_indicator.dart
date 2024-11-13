import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayLoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const OverlayLoadingIndicator(
    this.isLoading, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Positioned.fill(
        child: Container(
          color: Colors.white12,
          alignment: Alignment.center,
          child: Center(
            child: Platform.isAndroid
                ? const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                    ),
                  )
                : const CupertinoActivityIndicator(
                    radius: 16,
                  ),
          ),
        ),
      ),
    );
  }
}
