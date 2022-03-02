//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app/CutomizeControl/show_alert_Dialog.dart';
import 'package:untitled/app/service/auth_base.dart';
import 'package:untitled/app/sign_in/validator.dart';

enum EmailSignInFormType{signIn, register}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  EmailSignInForm ({@required this.auth});
  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm>  {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _submited = false;
  EmailSignInFormType _fromType = EmailSignInFormType.signIn;

  void _emailEditingComlete(){
    print('Test Focus'+ _email);
    FocusScope.of(context).requestFocus(_passwordFocus);
  }
  Future<void> _submit() async {
    setState(() {
      _submited = true;
    });
    try{
      if(_fromType == EmailSignInFormType.signIn){
        await widget.auth.signInWithEmailAndPassword(_email,_password);
      }
      else{
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    }
    catch(e){
      await showAlertDialog(
          context,
          title: 'Error',
          content: e.toString(),
          defaultActionText: 'OK');
    }

  }
  void _toggleFormType(){
    setState(() {
      _fromType = _fromType == EmailSignInFormType.signIn?EmailSignInFormType.register:EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChidren() {
    final primaryText = _fromType == EmailSignInFormType.signIn? 'Sign in': 'create an account';
    final secondText = _fromType == EmailSignInFormType.signIn? 'Need an account? Register': 'Have an account? Sign in';
    bool submitEnable = widget.emailValidator.isValid(_email)&& widget.passwordValidator.isValid(_password);
    return [
      _buildEmailTextFied(),
      SizedBox(height: 10.0,),
      _buildPassTextFied(),
      SizedBox(height: 10.0,),
      ElevatedButton(onPressed:submitEnable? _submit:null,
          child: Text(primaryText)),
      SizedBox(height: 10.0,),
      TextButton(
          onPressed:_toggleFormType,
          child: Text(secondText))

    ];
  }

  TextField _buildPassTextFied() {
    bool passValid = !widget.passwordValidator.isValid(_password) && _submited;
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: passValid? widget.invalidPasswordErrorText : null,
      ),
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocus,
      onChanged: _updateSate,

    );
  }

  TextField _buildEmailTextFied() {
    bool emailValid = !widget.emailValidator.isValid(_email)&& _submited;
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email', hintText: 'test@test.com',
        errorText:emailValid? widget.invalidEmailErrorText : null,
      ),
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComlete,
      onChanged:_updateSate,
    );
  }

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChidren(),
    ),
    );
  }
  void _updateSate(String value){
    setState((){
      print(_email);
    });
  }
}
