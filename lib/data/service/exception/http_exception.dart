import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/data/service/model/call_result.dart';

class HttpException implements Exception {
  final String cause;
  final int code;
  final BaseEntity? entity;
  final ErrorCause? error;

  HttpException({
    required this.cause,
    required this.code,
    this.entity,
    this.error,
  });
}
