import 'package:allcast_test_app/bitcoin_converter_bloc/bloc.dart';
import 'package:allcast_test_app/bitcoin_converter_bloc/events.dart';
import 'package:allcast_test_app/data/repository/bitcoin_repository.dart';
import 'package:allcast_test_app/data/services/bitcoin_api_service.dart';
import 'package:allcast_test_app/widget/bitcoin_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BitcoinConverterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BitcoinBloc(repository: BitcoinRepository(BitcoinApiService()))
            ..add(FetchBitcoinPrice()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('USD to BTC Converter'),
        ),
        body: Center(child: BitcoinConverter()),
      ),
    );
  }
}


