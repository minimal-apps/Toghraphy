part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class DeepBrown extends ThemeEvent {}

class DeepBlue extends ThemeEvent {}

class DeepRed extends ThemeEvent {}

class DeepGreen extends ThemeEvent {}

class DeepPink extends ThemeEvent {}

class DeepPurple extends ThemeEvent {}

class ShallowBrown extends ThemeEvent {}

class ShallowBlue extends ThemeEvent {}

class ShallowRed extends ThemeEvent {}

class ShallowGreen extends ThemeEvent {}

class ShallowPink extends ThemeEvent {}

class ShallowPurple extends ThemeEvent {}

class Black extends ThemeEvent {}

class White extends ThemeEvent {}
