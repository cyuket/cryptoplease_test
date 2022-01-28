import 'package:cryptoplease/counter/view/calculator.dart';
import 'package:cryptoplease/feature/bloc/test_bloc.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TestBloc(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  void initState() {
    context.read<TestBloc>().add(CounterIncrementPressed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tokens'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<TestBloc, List<TokenModel>>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    final token = state[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalcutatorPage(
                                  token: token,
                                )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              child: Text(
                                  '${token.symbol[0]}${token.symbol[1]}${token.symbol[2]}'),
                            ),
                            const Gap(20),
                            Expanded(child: Text(token.name)),
                            const Gap(20),
                            Text('${token.price} USD'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// class CounterText extends StatelessWidget {
//   const CounterText({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     // final count = context.select((CounterCubit cubit) => cubit.state);
//     return Text('$count', style: theme.textTheme.headline1);
//   }
// }
