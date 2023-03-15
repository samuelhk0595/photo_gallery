import 'package:get_it/get_it.dart';

abstract class Injector {
  final GetIt getItInstance;

  Injector(this.getItInstance);

  void core(GetIt i);
  void datasources(GetIt i);
  void repositories(GetIt i);
  void useCases(GetIt i);
  void cubits(GetIt i);

  void registerAll() {
    core(getItInstance);
    datasources(getItInstance);
    repositories(getItInstance);
    useCases(getItInstance);
    cubits(getItInstance);
  }
}
