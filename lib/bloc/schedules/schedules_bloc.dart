import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/datasources/schedule_remote_datasource.dart';
import '../../data/models/response/schedule_response_model.dart';


part 'schedules_event.dart';
part 'schedules_state.dart';
part 'schedules_bloc.freezed.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(const _Initial()) {
    on<SchedulesEvent>((event, emit) async {
      emit(const _Loading());
      final response = await ScheduleRemoteDatasource().getSchedules();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}