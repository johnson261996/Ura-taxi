import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';

//class SignupWidget extends StatelessWidget {
class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _registerFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _referTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _cpasswordTextController = TextEditingController();

  bool value = false;
  bool value2 =false;
  bool value3 =false;

   void Signup() {
    if (_registerFormKey.currentState!.validate()) {
        _registerFormKey.currentState!.save();
    }
  }

  static bool isValidEmail(String email) {
    print("email bool:" + RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email).toString());
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp =  RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, Routes.login),
        ),
        title: Text('Registration'),
        backgroundColor: Color(0xff804ed1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              key: _registerFormKey,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameTextController,
                    validator: (value) => validateName(
                      value,"First Name"
                    ),
                    decoration: InputDecoration(
                      hintText: "First Name",
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 20,top: 20),
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _lastnameTextController,
                    validator: (value) => validateName(
                      value,"Last Name"
                    ),
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 20,top: 20),
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller:_emailTextController,
                    decoration: const InputDecoration(
                    hintText: 'E-Mail',
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 20,top: 20)
                   ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Email can\'t be empty';
                      } else if(!isValidEmail(value)){
                        return 'Enter a valid  email';
                      }
                    }

                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                       Text(
                        "Gender",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Checkbox(
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value!;
                            value2 = false;
                          });
                        },
                      ),
                      const Text(
                        "Male",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(width: 50,),
                      Checkbox(
                        value: value2,
                        onChanged: (value) {
                          setState(() {
                            value2 = value!;
                            this.value = false;
                          });
                        },
                      ),
                      const Text(
                        "Female",
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordTextController,
                    obscureText: true,
                    validator: (value) => validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _cpasswordTextController,
                    obscureText: true,
                    validator: (value) => validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _phoneTextController,
                    validator: (value) => validateMobile(
                      value
                    ),
                    decoration: InputDecoration(
                      hintText: "Phone no",
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 20,top: 20),
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _referTextController,
                    validator: (value) => null,
                    decoration: InputDecoration(
                      hintText: "Referral No(optional)",
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 20,top: 20),
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: value3,
                        onChanged: (value) {
                          setState(() {
                            this.value3 = value!;
                          });
                        },
                      ),
                      const Flexible(
                        child: Text(
                          'I agree terms and conditions of this app',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xffa37edc)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if(value3)...[
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffa37edc),
                          padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                          shape: StadiumBorder(),
                        ),
                        child: Text("Sign Up"),
                        onPressed:()=>  value3 ? Signup() : null,

                      ),
                    ),
                  ]else ... [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffa37edc),
                          padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                          shape: StadiumBorder(),
                          onSurface: Colors.grey,
                        ),
                        child: Text("Sign Up"),
                        onPressed:null,

                      ),
                    ),
                  ],

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text(
                    'Already have an account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.black),
                  ),
                  const SizedBox(width:10),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    child: const Text(
                      'Login here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, color: Color(0xffa37edc)),
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    )
    );
  }

  static String? validateName( String? name,String? text) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return  text! + ' can\'t be empty';
    }
    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }


}


