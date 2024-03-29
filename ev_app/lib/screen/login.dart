
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/config.dart';
import 'package:my_flutter/models/login_request_model.dart';
import 'package:my_flutter/models/login_response_model.dart';
import 'package:my_flutter/screen/home.dart';
import 'package:my_flutter/screen/maphome.dart';
import 'package:my_flutter/screen/register.dart';
import 'package:my_flutter/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String testText = "";
  bool isAPIcallProcess =false;
  String user = "";
  String password = '';
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
        body: Form(
            key: globalKey,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Bg2.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(212, 17, 17, 1),
                      Color.fromRGBO(20, 20, 20, 1)
                    ]),
              ),
              child: Center(
                child: Container(
                    margin: const EdgeInsets.all(10.0),
                    width: screenWidth * 4 / 5,
                    height: height * 259 / 463,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                            },
                            icon: Icon(Icons.arrow_back_ios_new)),
                      ),
                      const Image(
                        image: AssetImage("assets/images/logo2.png"),
                        width: 110,
                      ),
                      const Text(
                        "EVBON",
                        style: TextStyle(
                            fontSize: 35.34,
                            color: Colors.black,
                            fontFamily: "BanglaMN"),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 34,
                        child: FormHelper.inputFieldWidget(
                          context,
                          "username",
                          "                           username",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return 'Host URL can\'t be empty.';
                            }

                            return null;
                          },
                          (onSavedVal) => {
                            this.user = onSavedVal.toString().trim(),
                          },
                          initialValue: "",
                          obscureText: false,
                          borderFocusColor: Colors.black,
                          prefixIconColor: Theme.of(context).primaryColor,
                          borderColor: Colors.black.withOpacity(0.2),
                          borderRadius: 8,
                          borderWidth: 1,
                          focusedBorderWidth: 1,
                          hintColor: Colors.black.withOpacity(0.2),
                          fontSize: 14,
                          hintFontSize: 14,
                          paddingLeft: 35,
                          paddingRight: 35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 34,
                        child: FormHelper.inputFieldWidget(
                          context,
                          "password",
                          "                       Password",
                          (onValidateVal) {
                            if (onValidateVal.isEmpty) {
                              return 'Host URL can\'t be empty.';
                            }

                            return null;
                          },
                          (onSavedVal) => {
                            this.password = onSavedVal.toString().trim(),
                          },
                          onChange: (val) {},
                          initialValue: "",
                          obscureText: false,
                          borderFocusColor: Colors.black,
                          prefixIconColor: Theme.of(context).primaryColor,
                          borderColor: Colors.black.withOpacity(0.2),
                          borderRadius: 8,
                          borderWidth: 1,
                          focusedBorderWidth: 1,
                          hintColor: Colors.black.withOpacity(0.2),
                          fontSize: 14,
                          hintFontSize: 14,
                          paddingLeft: 35,
                          paddingRight: 35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fixedSize: const Size(256, 34),
                          primary:
                              const Color.fromRGBO(76, 77, 79, 1), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              isAPIcallProcess = true;
                            });
                           LoginRequestModel model = LoginRequestModel(
                            username: user,
                             password: password);

                             APIService.login(model).then((respone) => {
                              if(respone){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                   return MapHomeScreen();}))
                              }else{
                                FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                   "Invalid Username/Pasword !",
                                    "OK",
                                   (){
                                    Navigator.pop(context);
                                   })
                              }
                             });
                          }
                          
                        },
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Color.fromRGBO(79, 175, 244, 1),
                              fontSize: 12),
                        ),
                        onPressed: () {},
                      ),
                    ])),
              ),
            )));
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}