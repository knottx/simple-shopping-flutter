// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppError _$AppErrorFromJson(Map<String, dynamic> json) => AppError(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AppErrorToJson(AppError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  return val;
}
