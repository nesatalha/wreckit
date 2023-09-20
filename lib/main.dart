import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wreckit_lib/app.dart';
import 'package:wreckit_lib/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(App());
}