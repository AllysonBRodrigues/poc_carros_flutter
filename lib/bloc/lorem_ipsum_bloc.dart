import 'package:carros/bloc/base_bloc.dart';
import 'package:carros/network/lorem_ipsum_api.dart';

class LoremIpsumBloc extends BaseBloc<String> {
  fetch() async {
    try {
      String text = await LoremIpsumApi.getLoremIpsum();
      add(text);
    } catch (e) {
      addError(e);
    }
  }

  void dispose() {
    dispose();
  }
}
