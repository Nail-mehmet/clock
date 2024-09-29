
import 'package:clocker/Components/color.dart';
import 'package:clocker/Components/my_button.dart';
import 'package:clocker/Components/my_textfield.dart';
import 'package:clocker/Components/square_tile.dart';
import 'package:clocker/Screens/Authentication/auth_service.dart';
import 'package:clocker/Screens/Authentication/forgot_password.dart';
import 'package:clocker/Screens/Authentication/politikalar%C4%B1m%C4%B1z_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login (BuildContext context) async{
    final authService = AuthService();
    // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }
    catch(e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
             /* Container(
                height: MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF01204E),
                ),
              ),*/
              Container(
                height: MediaQuery.of(context).size.height/1.11,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 145.0))
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Column(
                      children: [
                        Text(
                          "Giriş Yap",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                        SizedBox(height: 15,),
                        Text("Hi, welcome back, you have been missed"),
                        /*Container(
                          width: 200, // Genişlik ayarını buradan yapabilirsiniz
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Uygulamaya giriş yaparak ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'gizlilik politikalarımızı',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue, // Mavi renk
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Politikamiz()),
                                      );
                                      // Tıklanma işlemi burada yapılacak
                                      print('Gizlilik politikalarımız tıklandı');
                                      // Buraya gizlilik politikası sayfasına yönlendirme kodunu ekleyebilirsiniz
                                    },
                                ),
                                TextSpan(
                                  text: ' kabul etmiş olursunuz.',
                                ),
                              ],
                            ),
                          ),
                        ),*/
                        SizedBox(height: 25,),
                        Container(
                          width: 360,
                          child: MyTextField(
                            hintText: "Email",
                            obscureText: false,
                            controller: _emailController,
                            iconum: Icon(Icons.mail_outline_rounded),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 360,
                          child: PasswordField(
                            hintText: "Password",
                            controller: _passwordController,
                            iconum: Icon(Icons.password),
                          ),
                        ),


                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                                    );
                                  },
                                  child: Text("Forgot Password?"))),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("not a member? "),
                            GestureDetector(
                                onTap: onTap,
                                child: Text(
                                  "Register now?",style: TextStyle(fontWeight: FontWeight.bold),))
                          ],
                        ),
                        SizedBox(height: 30,),
                        MyButton(
                          text: "Login",
                          onTap: () => login(context),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Divider(thickness: 1.5,color: Colors.grey[400],)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Or continue with",style: TextStyle(color: Colors.grey[700]),),
                              ),
                              Expanded(child: Divider(thickness: 1.5,color: Colors.grey[400],)),
                            ],
                          ),
                        ),
                        SquareTile(imagePath: "assets/google.png", onTap: ()=> AuthService().signInWithGoogle(),),

                      ],

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 520.0, left: 150,right: 150),
                child: Container(
                  height: 120,
                  child: Image.asset("assets/clock.png"),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
