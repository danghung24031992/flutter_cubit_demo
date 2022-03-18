import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<int> {
  CounterCubit() : super(0);
  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['counter'] as int;
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return {'counter': state};
  }
}
