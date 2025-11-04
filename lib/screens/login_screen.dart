import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:loginsignup/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  // Bottom toast message
  void showBottomToast(String message, {Color bgColor = Colors.black87}) {
    Widget toast = Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: bgColor,
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      try {
        await authProvider.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Login successful
        showBottomToast("Login successful", bgColor: Colors.blue);
        Navigator.pushReplacementNamed(context, '/main');

      } catch (e) {
        print("Full API error: $e");

        // Extract only the message part
        String errorMessage = e.toString();
        final match = RegExp(r'"message"\s*:\s*"([^"]+)"').firstMatch(errorMessage);

        if (match != null) {
          errorMessage = match.group(1)!;
        } else if (errorMessage.startsWith("Exception: ")){
          errorMessage = errorMessage.replaceFirst("Exception: ", "");
        }

        showBottomToast(errorMessage, bgColor: Colors.red);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.blueGrey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('assets/illustration.png'),
                ),
              ),
              const SizedBox(height: 40),

              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Enter email"),
                        EmailValidator(errorText: "Enter valid email"),
                      ]),
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        prefixIcon: const Icon(Icons.email, color: Colors.green,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password with eye icon
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Enter password"),
                        MinLengthValidator(8, errorText: "Minimum 8 characters"),
                        PatternValidator(
                          r'(?=.*?[#?!@$%^&*-_])',
                          errorText: "Include at least one special character",
                        ),
                      ]),
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        prefixIcon: const Icon(Icons.lock, color: Colors.green),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Forget Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showBottomToast(
                              "Forgot password clicked", bgColor: Colors.orange);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () => handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
