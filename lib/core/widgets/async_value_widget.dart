import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.data,
    super.key,
    this.loadingMessage,
  });

  final AsyncValue<T> value;
  final Widget Function(T value) data;
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (error, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            error.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      loading: () => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (loadingMessage != null) ...[
              const SizedBox(height: 16),
              Text(loadingMessage!),
            ],
          ],
        ),
      ),
    );
  }
}

