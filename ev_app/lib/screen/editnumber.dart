import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class EditNumberScreen extends StatefulWidget {
  const EditNumberScreen({Key? key}) : super(key: key);

  @override
  State<EditNumberScreen> createState() => _EditNumberScreenState();
}

class _EditNumberScreenState extends State<EditNumberScreen> {
  @override
  String testText = "";
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Phone Number',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromRGBO(20, 20, 20, 1),
          elevation: 1,
        ),
        body: Container(
          color: Color.fromRGBO(20, 20, 20, 1),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: FormHelper.inputFieldWidget(
                  context,
                  "newphonenumber",
                  "New Phone Number",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'Host URL can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    this.testText = onSavedVal,
                  },
                  initialValue: this.testText,
                  obscureText: false,
                  borderFocusColor: Colors.white,
                  prefixIconColor: Theme.of(context).primaryColor,
                  borderColor: Colors.white,
                  borderRadius: 8,
                  borderWidth: 1,
                  focusedBorderWidth: 1,
                  hintColor: Colors.white,
                  fontSize: 14,
                  hintFontSize: 14,
                  paddingLeft: 35,
                  paddingRight: 35,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  fixedSize: const Size(292, 50),
                  primary: const Color.fromRGBO(76, 77, 79, 1), // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Save changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}
