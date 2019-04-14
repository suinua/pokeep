import 'package:bloc_provider/bloc_provider.dart';
import 'package:pokeep/models/me.dart';
import 'package:rxdart/rxdart.dart';

class MeBloc implements Bloc {
  Me _me;

  BehaviorSubject<Me> _meController = BehaviorSubject<Me>();

  Sink<Me> get _setValue => _meController.sink;

  Stream<Me> get me => _meController.stream;

  BehaviorSubject<Me> _registerController = BehaviorSubject<Me>();
  BehaviorSubject<Me> _loginController = BehaviorSubject<Me>();
  BehaviorSubject<void> _logoutController = BehaviorSubject<void>();

  MeBloc() {
    _registerController.stream.listen((Me me) {
      //TODO : register実装
    });
    _loginController.stream.listen((Me me) {
      //TODO : login実装
    });
    _logoutController.stream.listen(null);
  }

  @override
  void dispose() async {
    await _meController.close();
    await _registerController.close();
    await _loginController.close();
    await _logoutController.close();
  }
}
