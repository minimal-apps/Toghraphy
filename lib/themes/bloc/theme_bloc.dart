import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:toghraphy/themes/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> with HydratedMixin {
  ThemeBloc()
      : super(
          const ThemeState(
              primaryColor: ThemeColors.white,
              secondaryColor: ThemeColors.black,
              bubbleColor: ThemeColors.darkGrey,
              backgroundColor: ThemeColors.milky,),
        ) {
    on<DeepBrown>(_onDeepBrown);
    on<DeepBlue>(_onDeepBlue);
    on<DeepRed>(_onDeepRed);
    on<DeepGreen>(_onDeepGreen);
    on<DeepPink>(_onDeepPink);
    on<DeepPurple>(_onDeepPurple);
    on<ShallowBrown>(_onShallowBrown);
    on<ShallowBlue>(_onShallowBlue);
    on<ShallowRed>(_onShallowRed);
    on<ShallowGreen>(_onShallowGreen);
    on<ShallowPink>(_onShallowPink);
    on<ShallowPurple>(_onShallowPurple);
    on<Black>(_onBlack);
    on<White>(_onWhite);
  }

  void _onDeepBrown(DeepBrown event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.white,
      secondaryColor: ThemeColors.black,
      backgroundColor: ThemeColors.milky,
      bubbleColor: ThemeColors.deepBrown,
    ),);
  }

  void _onDeepBlue(DeepBlue event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.white,
      secondaryColor: ThemeColors.black,
      backgroundColor: ThemeColors.milky,
      bubbleColor: ThemeColors.deepBlue,
    ),);
  }

  void _onDeepRed(DeepRed event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.white,
      secondaryColor: ThemeColors.black,
      backgroundColor: ThemeColors.milky,
      bubbleColor: ThemeColors.deepRed,
    ),);
  }

  void _onDeepGreen(DeepGreen event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.white,
      secondaryColor: ThemeColors.black,
      backgroundColor: ThemeColors.milky,
      bubbleColor: ThemeColors.deepGreen,
    ),);
  }

  void _onDeepPink(DeepPink event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.white,
      secondaryColor: ThemeColors.black,
      backgroundColor: ThemeColors.milky,
      bubbleColor: ThemeColors.deepPink,
    ),);
  }

  void _onDeepPurple(DeepPurple event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.white,
      secondaryColor: ThemeColors.black,
      backgroundColor: ThemeColors.milky,
      bubbleColor: ThemeColors.deepPurple,
    ),);
  }

  void _onShallowBrown(ShallowBrown event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.black,
      secondaryColor: ThemeColors.white,
      backgroundColor: ThemeColors.darkGrey,
      bubbleColor: ThemeColors.shallowBrown,
    ),);
  }

  void _onShallowBlue(ShallowBlue event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.black,
      secondaryColor: ThemeColors.white,
      backgroundColor: ThemeColors.darkGrey,
      bubbleColor: ThemeColors.shallowBlue,
    ),);
  }

  void _onShallowRed(ShallowRed event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.black,
      secondaryColor: ThemeColors.white,
      backgroundColor: ThemeColors.darkGrey,
      bubbleColor: ThemeColors.shallowRed,
    ),);
  }

  void _onShallowGreen(ShallowGreen event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.black,
      secondaryColor: ThemeColors.white,
      backgroundColor: ThemeColors.darkGrey,
      bubbleColor: ThemeColors.shallowGreen,
    ),);
  }

  void _onShallowPink(ShallowPink event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.black,
      secondaryColor: ThemeColors.white,
      backgroundColor: ThemeColors.darkGrey,
      bubbleColor: ThemeColors.shallowPink,
    ),);
  }

  void _onShallowPurple(ShallowPurple event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      primaryColor: ThemeColors.black,
      secondaryColor: ThemeColors.white,
      backgroundColor: ThemeColors.darkGrey,
      bubbleColor: ThemeColors.shallowPurple,
    ),);
  }

  void _onBlack(Black event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
        primaryColor: ThemeColors.white,
        secondaryColor: ThemeColors.black,
        bubbleColor: ThemeColors.darkGrey,
        backgroundColor: ThemeColors.milky,),);
  }

  void _onWhite(White event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
        primaryColor: ThemeColors.black,
        secondaryColor: ThemeColors.white,
        bubbleColor: ThemeColors.milky,
        backgroundColor: ThemeColors.darkGrey,),);
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
