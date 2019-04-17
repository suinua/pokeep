import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';


class MyItemsBlocProvider extends BlocProvider<MyItemsBloc> {
  MyItemsBlocProvider({
    @required MyItemsBloc value,
  }) : super(
    creator: (context, _bag) {
      assert(context != null);
      return value;
    },
  );

  MyItemsBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static MyItemsBloc of(BuildContext context) => BlocProvider.of(context);
}
