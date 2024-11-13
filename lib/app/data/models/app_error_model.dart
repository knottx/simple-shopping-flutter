import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_error_model.g.dart';

@JsonSerializable()
class AppError extends Equatable implements Exception {
  final String? message;

  const AppError({
    this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];

  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);

  Map<String, dynamic> toJson() => _$AppErrorToJson(this);

  @override
  String toString() {
    return message ?? '';
  }
}
