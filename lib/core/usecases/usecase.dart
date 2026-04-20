/// Abstract base class for all use cases.
///
/// [Type] is the return type, [Params] is the input parameter type.
/// Use [NoParams] when the use case requires no input.
abstract class UseCase<Output, Params> {
  Future<Output> call(Params params);
}

/// Use as [Params] for use cases that take no input.
class NoParams {
  const NoParams();
}
