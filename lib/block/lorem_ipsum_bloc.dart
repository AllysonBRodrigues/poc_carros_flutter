import 'dart:async';

import 'package:carros/network/lorem_ipsum_api.dart';

class LoremIpsumBloc {

final _streamController = StreamController<String>();

  get strean => _streamController.stream;

  fetch() async {
    try {
      String text = await LoremIpsumApi.getLoremIpsum();
      _streamController.add(text);
    } catch (e){
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }

}