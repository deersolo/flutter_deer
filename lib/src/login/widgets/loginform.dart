import 'package:another_flushbar/flushbar.dart';
import 'package:deersolo/src/utils/RegexValidator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:deersolo/config/theme.dart' as custom_theme;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final gradienStart = custom_theme.Theme.gradientStart;
  final gradienEnd = custom_theme.Theme.gradientEnd;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  String? _errorUser;
  String? _errorPasswd;

  get fontFamily => null;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
    _errorUser = ' ';
    _errorPasswd = ' ';
  }

  @override
  void dispose() {
    usernameController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(alignment: Alignment.bottomCenter, children: [
      _buildForm(),
      _buildSubmitButton(),
    ]);
  }

  Card _buildForm() => Card(
        margin: const EdgeInsets.only(bottom: 22, left: 22, right: 22),
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 60),
          child: FormInput(
              usernameController: usernameController,
              passwordController: passwordController,
              errorUser: _errorUser!,
              errorPasswd: _errorPasswd!,
          ),
        ),
      );

  Container _buildSubmitButton() => Container(
      width: 220,
      height: 50,
      decoration: _boxDecoration(),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: _onLogin,
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),

        ),

      ));

  BoxDecoration _boxDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          boxShadowItem(gradienStart),
          boxShadowItem(gradienEnd),
        ],
        gradient: LinearGradient(
          colors: [
            gradienEnd,
            gradienStart,
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1, 1),
          stops: const [0.0, 1.0],
        ),
      );

  BoxShadow boxShadowItem(Color color) => BoxShadow(
        color: color,
        offset: const Offset(1.0, 6.0),
        blurRadius: 20.0,
      );

  void showAlertBar() {
    Flushbar(
      title: "Hey Ninja", //ignored since titleText != null
      message: "Username or Password is incorrect.", //ignored since messageText != null
      titleText: Text("Hello Hero",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,
            color: Colors.orange[500],
            fontFamily:"ShadowsIntoLightTwo"),

      ),
      messageText: Text("Username or Password is incorrect.",
        style: TextStyle(fontSize: 16.0, color: Colors.blue[500],
        ),
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void showAlertBarOk() {
    Flushbar(
      title: "Hello", //ignored since titleText != null
      message: "login successfully.", //ignored since messageText != null
      titleText: Text("Hello",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,
            color: Colors.yellow[600],
            fontFamily:"ShadowsIntoLightTwo"),
      ),
      messageText: Text("login successfully.",
        style: TextStyle(fontSize: 16.0, color: Colors.green[500],
        ),
      ),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
  void showLoading(){
    Flushbar(
      message: "Loading...", //ignored since messageText != null
      showProgressIndicator: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  void _onLogin() {
      String username = usernameController.text;
      String password = passwordController.text;
      _errorUser = '';
      _errorPasswd = '';
      if(!EmailSubmitRegexValidator().isValid(username)){
        _errorUser = 'email not ok.';
      }else{
        _errorUser = '';
      }
      if(password.length < 8){
        _errorPasswd = 'must be at least 8 characters.';
      }else{
        _errorPasswd = '';
      }
      if(_errorUser == null && _errorPasswd == null){
        print('mai me data send!');
      }else{
        showLoading();
        Future.delayed(const Duration(seconds: 2)).then((value){
          Navigator.pop(context);
          if(username == 'deer@ceo.th' && password == '12345678'){
            showAlertBarOk();
            print('login successfully');
            setState(() {

            });
          }
          else{
            showAlertBar();
            setState(() {

            });
            print('login Failed');
          }
        });
        print('me data send');
        setState(() {

        });
      }
      print(usernameController.text);
      print(passwordController.text);
    }
}

class FormInput extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String errorUser;
  final String errorPasswd;

  const FormInput({
    Key? key, required this.usernameController, required this.passwordController, required this.errorUser, required this.errorPasswd,
  }) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  late bool _obscureTextPassword;
  final _passwordFocusNode = FocusNode();

  @override
  void initState(){
    _obscureTextPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUsername(),
        _buildPassword(),
      ],
    );
  }

  TextField _buildUsername() => TextField(
        controller: widget.usernameController,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Email Address',
            hintText: 'admin@g-tec.co.th',
            icon: const FaIcon(
              FontAwesomeIcons.envelope,
              size: 22.0,
              color: Colors.black54,
            ),
          errorText: widget.errorUser,
        ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSubmitted: (String value){
          FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      );

  TextField _buildPassword() => TextField(
    focusNode: _passwordFocusNode,
      controller: widget.passwordController,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            icon: const FaIcon(
              FontAwesomeIcons.lock,
              size: 22.0,
              color: Colors.black54,
            ),
          errorText: widget.errorPasswd,
          suffix: IconButton(
            icon: FaIcon(_obscureTextPassword
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
                color: Colors.black54,
                size: 15.0,
            ),
            onPressed: () {
              setState((){
                _obscureTextPassword = !_obscureTextPassword;
              });
            }),
        ),
        obscureText: _obscureTextPassword,
      );
}
