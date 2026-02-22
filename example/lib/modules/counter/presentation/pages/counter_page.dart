import 'package:flutter/material.dart';
import 'package:fkappa/fkappa.dart';
import '../bloc/counter_bloc.dart';

class CounterPage extends StatelessWidget with FKappaSpacing {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('fkappa Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current Counter Value:',
              style: TextStyle(fontSize: 18),
            ),
            FKappaSpacing.mediumV,
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                if (state is CounterLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CounterSuccess) {
                  return Text(
                    '${state.value}',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  );
                } else if (state is CounterError) {
                  return Text('Error: ${state.message}', style: const TextStyle(color: Colors.red));
                }
                return const Text('0', style: TextStyle(fontSize: 48));
              },
            ),
            FKappaSpacing.largeV,
            FKappaButton(
              label: 'Increment Counter',
              onPressed: () {
                final bloc = context.read<CounterBloc>();
                final currentValue = bloc.state is CounterSuccess 
                    ? (bloc.state as CounterSuccess).value 
                    : 0;
                bloc.add(IncrementEvent(currentValue));
              },
            ),
            FKappaSpacing.mediumV,
            TextButton(
              onPressed: () => context.push('/history'),
              child: const Text('View Global History (Event Bus Demo)'),
            ),
          ],
        ),
      ),
    );
  }
}
