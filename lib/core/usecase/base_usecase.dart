import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
