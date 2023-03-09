

import 'package:bog/core/widgets/input_text_field.dart';

import '../../app/base/base.dart';

class InputMixin {

  List<InputTextFieldModel> inputModels = [];

  //studs is a string function to execute and check for a null response
  //studs use an int index as key
  bool validateInputModels({Map studs=const {}}) {
    for (int index = 0; index < inputModels.length; index++) {
      if(studs.containsKey(index)){
        String? proceed = studs[index]();
        if(proceed!=null){
          showPopup(proceed);
          return false;
        }
      }
      InputTextFieldModel input = inputModels[index];
      String text = input.textController.text.toString().trim();
      if (text.isEmpty && !input.optional) {
        input.focusNode.requestFocus();
        showPopup(input.hint??"Enter ${input.title.toLowerCase()}");
        return false;
      }
    }
    return true;
  }

/*Column inputModelWidgets(int start,{int? end}) {
    end = end ?? inputModels.length;
    return Column(
      children: List.generate(end-start, (i) {
        int index = i + start;
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: InputTextField(inputTextFieldModel: inputModels[index],),
        );
      }),
    );
  }*/
}