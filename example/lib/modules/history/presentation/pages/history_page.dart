import 'package:flutter/material.dart';
import 'package:fkappa/kappa.dart';
import '../bloc/history_bloc.dart';

class HistoryPage extends StatelessWidget with KappaSpacing {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global History Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => context.read<HistoryBloc>().add(ClearHistoryEvent()),
          )
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state.logs.isEmpty) {
            return const Center(child: Text('No events recorded yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(KappaSpacing.medium),
            itemCount: state.logs.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final log = state.logs[index];
              return ListTile(
                leading: const Icon(Icons.history, color: Colors.blue),
                title: Text('Counter changed to: ${log['value']}'),
                subtitle: Text('At: ${log['time']}'),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          );
        },
      ),
    );
  }
}
