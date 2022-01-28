import 'package:cryptoplease/core/decimal_input_formatter.dart';
import 'package:cryptoplease/feature/data/model/token_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CalcutatorPage extends StatefulWidget {
  const CalcutatorPage({
    Key? key,
    required this.token,
  }) : super(key: key);

  final TokenModel token;

  @override
  _CalcutatorPageState createState() => _CalcutatorPageState();
}

class _CalcutatorPageState extends State<CalcutatorPage> {
  final tokenController = TextEditingController();
  final usdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.token.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: tokenController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final cal = double.parse(value) * widget.token.price!;
                    usdController.text = cal.toString();
                  } else {
                    usdController.text = '0';
                  }
                },
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 9)],
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Coin'),
                ),
              ),
              const Gap(20),
              TextField(
                controller: usdController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final cal = double.parse(value) / widget.token.price!;
                    tokenController.text = cal.toString();
                  } else {
                    tokenController.text = '0';
                  }
                },
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 9)],
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('USD'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
