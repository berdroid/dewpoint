part of 'dewpoint_cubit.dart';

@immutable
class DewPointState extends Equatable {
  final double temperature;
  final double dewPoint;
  final double relHumidity;
  final double absHumidity;
  final bool locked;

  const DewPointState({
    this.temperature = 20.0,
    this.dewPoint = 9.0,
    this.relHumidity = 50.0,
    this.absHumidity = 8.7,
    this.locked = false,
  });

  DewPointState copyWith({
    double? temperature,
    double? dewPoint,
    double? relHumidity,
    double? absHumidity,
    bool? locked,
  }) =>
      DewPointState(
        temperature: temperature ?? this.temperature,
        dewPoint: dewPoint ?? this.dewPoint,
        relHumidity: relHumidity ?? this.relHumidity,
        absHumidity: absHumidity ?? this.absHumidity,
        locked: locked ?? this.locked,
      );

  @override
  List<Object?> get props => [temperature, relHumidity, dewPoint, absHumidity, locked];

  @override
  bool get stringify => true;
}
