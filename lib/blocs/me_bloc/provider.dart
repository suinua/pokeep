import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';


class MeBlocProvider extends BlocProvider<MeBloc> {
  MeBlocProvider({
    @required MeBloc value,
  }) : super(
    creator: (context, _bag) {
      assert(context != null);
      return value;
    },
  );

  MeBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static MeBloc of(BuildContext context) => BlocProvider.of(context);
}
