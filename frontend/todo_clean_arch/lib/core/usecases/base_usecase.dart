import 'package:dartz/dartz.dart';
import '../err/failure_abstract_class.dart';

abstract class BaseUsecase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParams {
  const NoParams();
}
