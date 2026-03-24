import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/enum_label.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/application/auth_controller.dart';
import '../application/support_controller.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({super.key});

  static const routePath = '/support';

  @override
  ConsumerState<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserIdProvider);
    final tickets = userId == null
        ? const AsyncValue<List<dynamic>>.data(<dynamic>[])
        : ref.watch(supportTicketsProvider(userId));
    final state = ref.watch(supportControllerProvider);

    return AppShell(
      title: 'Help and support',
      body: ListView(
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Contact options'),
                const SizedBox(height: 8),
                Text(AppConstants.supportPhone),
                Text(AppConstants.supportEmail),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _subjectController,
            decoration: const InputDecoration(labelText: 'Subject'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Describe the issue'),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Raise ticket',
            isLoading: state.isLoading,
            icon: Icons.support_agent_rounded,
            onPressed: userId == null
                ? null
                : () async {
                    await ref.read(supportControllerProvider.notifier).createTicket(
                          userId: userId,
                          subject: _subjectController.text.trim(),
                          description: _descriptionController.text.trim(),
                        );
                    _subjectController.clear();
                    _descriptionController.clear();
                  },
          ),
          const SizedBox(height: 24),
          tickets.when(
            data: (items) {
              final list = items.cast<dynamic>();
              if (list.isEmpty) {
                return const Text('No support tickets raised yet.');
              }
              return Column(
                children: list
                    .map(
                      (ticket) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SectionCard(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(ticket.subject.toString()),
                            subtitle: Text(enumLabel(ticket.status)),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString()),
          ),
        ],
      ),
    );
  }
}
