import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppOpened>(_onAppOpened);
  }
  Future<void> _onAppOpened(
    AppOpened event,
    Emitter<AppState> emit,
  ) async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString('name') == null){
    emit(state.copyWith(status: PageStatus.unauthenticated));
    }else{
    emit(state.copyWith(status: PageStatus.authenticated));
    }
  }
}
