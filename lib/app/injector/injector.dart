import 'package:get_it/get_it.dart';

abstract class Injector {
  final GetIt getItInstance;

  Injector(this.getItInstance);

  void stores(GetIt i);
  void core(GetIt i);
  void datasources(GetIt i);
  void repositories(GetIt i);
  void useCases(GetIt i);
  void controllers(GetIt i);

  void registerAll() {
    stores(getItInstance);
    core(getItInstance);
    datasources(getItInstance);
    repositories(getItInstance);
    useCases(getItInstance);
    controllers(getItInstance);
  }
}
