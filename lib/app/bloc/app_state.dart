part of 'app_bloc.dart';

enum PageStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({this.status = PageStatus.unauthenticated});
  final PageStatus status;
  @override
  List<Object> get props => [status];

  AppState copyWith({
    PageStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }
}
