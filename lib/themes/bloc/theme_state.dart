// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color bubbleColor;
  ThemeState({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.bubbleColor,
  });


  @override
  List<Object> get props => [primaryColor, secondaryColor, backgroundColor, bubbleColor];

 

  ThemeState copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? bubbleColor,
  }) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bubbleColor: bubbleColor ?? this.bubbleColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'primaryColor': primaryColor.value,
      'secondaryColor': secondaryColor.value,
      'backgroundColor': backgroundColor.value,
      'bubbleColor': bubbleColor.value,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      primaryColor: Color(map['primaryColor'] as int),
      secondaryColor: Color(map['secondaryColor'] as int),
      backgroundColor: Color(map['backgroundColor'] as int),
      bubbleColor: Color(map['bubbleColor'] as int),
    );
  }

}
