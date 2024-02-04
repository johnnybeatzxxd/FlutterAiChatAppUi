import "package:flutter/material.dart";
import "index.dart";

class SignupPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final _signupEmailFormKey = GlobalKey<FormState>(debugLabel: "SignUpEmail");
  final _signupUsernameFormKey =
      GlobalKey<FormState>(debugLabel: "SignUpUsername");
  final _signupPassFormKey = GlobalKey<FormState>(debugLabel: "SignUpPass");
  final _signupConPassFormKey =
      GlobalKey<FormState>(debugLabel: "SignUpConPass");
  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
                context.read<ThemeIconProvider>().toggleIcon();
              },
              icon: Icon(Provider.of<ThemeIconProvider>(context).icontype))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
              "Welcome to signup page!",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  //width: 160,
                  child: SignInputBox(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: "Email",
                    obscureText: false,
                    formkey: _signupEmailFormKey,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 150,
                  child: SignInputBox(
                    controller: usernameController,
                    labelText: 'Name',
                    hintText: "Username",
                    obscureText: false,
                    formkey: _signupUsernameFormKey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SignInputBox(
              controller: passwordController,
              labelText: 'Enter your password',
              hintText: "Password",
              obscureText: true,
              formkey: _signupPassFormKey,
            ),
            SizedBox(
              height: 10,
            ),
            SignInputBox(
              controller: confirmPasswordController,
              labelText: 'Confirm password',
              hintText: "Confirm Password",
              obscureText: true,
              formkey: _signupConPassFormKey,
            ),
            SizedBox(
              height: 20,
            ),
            SignButton(
                text: 'Sign up',
                on_tap: () async {
                  print("button pressed!");
                  await Provider.of<ChatProvider>(context, listen: false)
                      .switchLoading();
                  if (emailController.text != "" ||
                      passwordController.text != "" ||
                      confirmPasswordController.text != "") {
                    var userAuth = await Account().signup(
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text);

                    if (userAuth == "User created") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                
                    else {
                    _signupEmailFormKey.currentState!.validate();
                    _signupUsernameFormKey.currentState!.validate();
                    _signupPassFormKey.currentState!.validate();
                    _signupConPassFormKey.currentState!.validate();
                  }
                  } 
                  await Provider.of<ChatProvider>(context, listen: false)
                      .switchLoading();
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an "),
                InkWell(
                  child: Text(
                    'account.',
                    style: TextStyle(
                        color: Colors.blue[900], fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.pop(context),
                )
              ],
            )
          ])),
        ),
      ),
    );
  }
}
