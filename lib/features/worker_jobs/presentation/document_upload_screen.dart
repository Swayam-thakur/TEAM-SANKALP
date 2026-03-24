import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/section_card.dart';
import '../../../shared/models/app_enums.dart';
import '../../auth/application/auth_controller.dart';
import '../../worker_dashboard/application/worker_dashboard_controller.dart';

class DocumentUploadScreen extends ConsumerWidget {
  const DocumentUploadScreen({super.key});

  static const routePath = '/worker-documents';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workerId = ref.watch(currentUserIdProvider);

    return AppShell(
      title: 'Documents',
      body: ListView(
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload verification files to support approval workflows.',
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: workerId == null
                      ? null
                      : () => ref
                          .read(workerDashboardControllerProvider.notifier)
                          .uploadDocument(
                            workerId: workerId,
                            type: DocumentType.idProof,
                          ),
                  icon: const Icon(Icons.badge_outlined),
                  label: const Text('Upload ID proof'),
                ),
                const SizedBox(height: 12),
                FilledButton.tonalIcon(
                  onPressed: workerId == null
                      ? null
                      : () => ref
                          .read(workerDashboardControllerProvider.notifier)
                          .uploadDocument(
                            workerId: workerId,
                            type: DocumentType.serviceProof,
                          ),
                  icon: const Icon(Icons.workspace_premium_outlined),
                  label: const Text('Upload service proof'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

