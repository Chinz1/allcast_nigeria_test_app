import 'package:equatable/equatable.dart';

// Events

abstract class BitcoinEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBitcoinPrice extends BitcoinEvent {}

class ConvertUsdToBtc extends BitcoinEvent {
  final double usdAmount;

  ConvertUsdToBtc(this.usdAmount);

  @override
  List<Object> get props => [usdAmount];
}


