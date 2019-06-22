import 'dart:async';

import 'package:bongdaphui/models/soccer_field.dart';

class FieldBloc {
  final postController = StreamController<List<SoccerField>>();
  final fabController = StreamController<bool>();
  final fabVisibleController = StreamController<bool>();

  Sink<bool> get fabSink => fabController.sink;

  Stream<List<SoccerField>> get postItems => postController.stream;

  Stream<bool> get fabVisible => fabVisibleController.stream;

  FieldBloc(List<SoccerField> fields) {
    postController.add(fields);
    fabController.stream.listen(onScroll);
  }

  onScroll(bool visible) {
    fabVisibleController.add(visible);
  }

  void dispose() {
    postController?.close();
    fabController?.close();
    fabVisibleController?.close();
  }
}
