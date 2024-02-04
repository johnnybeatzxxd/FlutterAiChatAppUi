import "package:chat_app/index.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class SigninPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _signinEmailFormKey = GlobalKey<FormState>(debugLabel: 'Username');
  final _signinPassFormKey = GlobalKey<FormState>(debugLabel: 'Password');
  static const routeName = '/signin';
  SigninPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
                context.read<ThemeIconProvider>().toggleIcon();
              }, //
              icon: Icon(Provider.of<ThemeIconProvider>(context).icontype))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: Center(
            child: Column(children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle,
                size: 100,
              )),
          SizedBox(height: 20),
          Text(
            "Welcome to signin page!",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          SignInputBox(
            controller: usernameController,
            labelText: 'Enter your username',
            hintText: "Username",
            obscureText: false,
            formkey: _signinEmailFormKey,
          ),
          SizedBox(
            height: 10,
          ),
          SignInputBox(
            controller: passwordController,
            labelText: 'Enter your password',
            hintText: "Password",
            obscureText: true,
            formkey: _signinPassFormKey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SignButton(
              text: "Signin",
              on_tap: () async {
                print("button pressed!");
                await Provider.of<ChatProvider>(context, listen: false)
                    .switchLoading();
                print("switched!");
                var auth = await Account()
                    .login(usernameController.text, passwordController.text);

                if (auth == "User Authenticated") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  _signinEmailFormKey.currentState!.validate();
                  _signinPassFormKey.currentState!.validate();
                }
                await Provider.of<ChatProvider>(context, listen: false)
                    .switchLoading();
                ;
              }),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I don't have an "),
              InkWell(
                child: Text(
                  'account',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage())),
              )
            ],
          )
        ])),
      ),
    );
  }
}
