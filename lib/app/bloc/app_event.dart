part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class NavigationTriggered extends AppEvent {
  const NavigationTriggered({
    required this.status,
  });
  final PageStatus status;
  @override
  List<Object> get props => [status];
}
