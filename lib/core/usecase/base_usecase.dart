import 'package:dartz/dartz.dart';
import 'package:else7a_tamam/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
