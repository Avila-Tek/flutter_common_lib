// ignore_for_file: one_member_abstracts

import 'package:code_standards/core/typedefs/response.dart';

abstract class UseCaseWithParams<Type, Params> {
  ResultFuture<Type> call(Params parameters);
}

abstract class UseCaseWithoutParams<Type> {
  ResultFuture<Type> call();
}
