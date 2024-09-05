import 'package:allcast_test_app/bitcoin_converter_bloc/bloc.dart';
import 'package:allcast_test_app/bitcoin_converter_bloc/events.dart';
import 'package:allcast_test_app/bitcoin_converter_bloc/state.dart';
import 'package:allcast_test_app/utils/amount_masked_formatter.dart';
import 'package:allcast_test_app/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BitcoinConverter extends StatefulWidget {
  @override
  _BitcoinConverterState createState() => _BitcoinConverterState();
}

class _BitcoinConverterState extends State<BitcoinConverter> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BitcoinBloc, BitcoinState>(
      builder: (context, state) {
        if (state is BitcoinLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BitcoinLoaded) {
          return Container(
            width: 450,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '1 BTC = ${state.bitcoinPrice.usd} USD',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  'Last Updated: ${DateFormat('yyyy-MM-dd  HH:mm:ss').format(state.lastUpdated)}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  title: 'Enter USD amount',
                  isMoney: true,
                  labelText: 'Enter up to \$100,000,000',
                  prefix: '\$ ',
                  controller: _controller,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                    AmountMaskedFormatter()
                  ],
                  onChanged: (value) {
                    final usdAmount = double.tryParse(
                            value.replaceAll(',', '').replaceAll('\$', '')) ??
                        0.0;
                    if (usdAmount > 0 && usdAmount <= 100000000) {
                      context
                          .read<BitcoinBloc>()
                          .add(ConvertUsdToBtc(usdAmount));
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Converted BTC: ${state.convertedBtc > 0 ? state.convertedBtc.toStringAsFixed(8) : '-- '}', // Show neutral value if not available
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        } else if (state is BitcoinError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No Data Available'));
        }
      },
    );
  }
}
