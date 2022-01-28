// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:cryptoplease/app/app.dart';
import 'package:cryptoplease/bootstrap.dart';
import 'package:cryptoplease/core/injections/locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependecies();
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}
