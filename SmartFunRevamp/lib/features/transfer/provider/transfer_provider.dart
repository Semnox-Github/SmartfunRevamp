import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_state.dart';
part 'transfer_provider.freezed.dart';

final transferProvider = StateNotifierProvider<TransferProvider, TransferState>(
  (ref) => TransferProvider(),
);

class TransferProvider extends StateNotifier<TransferState> {
  TransferProvider() : super(const _MyCard());
}
