import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/domain/entities/registration_entities.dart';
import 'package:mconnect_app/presentation/logic/provider/user_reg_provider.dart';
import 'package:mconnect_app/utils/validations/register_validations.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: Text(
              "Register",
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF3D3E8A)),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              height: MediaQuery.of(context).size.height * 0.875,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Name",
                              labelStyle: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(17)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              errorStyle: TextStyle(height: 0.2),
                            ),
                            validator: (value) =>
                                RegisterValidations.validateName(value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _mobileController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.phone_iphone_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Mobile",
                              labelStyle: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(17)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              errorStyle: TextStyle(height: 0.2),
                            ),
                            validator: (value) =>
                                RegisterValidations.validateMobile(value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            filled: true,
                            labelText: "Email",
                            labelStyle: GoogleFonts.raleway(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(17)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            errorStyle: TextStyle(height: 0.2),
                          ),
                          validator: (value) =>
                              RegisterValidations.validateEmail(value),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                            controller: _designationController,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Designation",
                              labelStyle: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(17)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              errorStyle: TextStyle(height: 0.2),
                            ),
                            validator: (value) =>
                                RegisterValidations.validateDesignation(value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                            obscureText: !passwordVisible,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: passwordVisible
                                      ? Icon(Icons.visibility_outlined)
                                      : Icon(Icons.visibility_off_outlined),
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Password",
                              labelStyle: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(17)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              errorStyle: TextStyle(height: 0.2),
                            ),
                            validator: (value) =>
                                RegisterValidations.validatePassword(value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                            obscureText: !confirmPasswordVisible,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible;
                                    });
                                  },
                                  icon: confirmPasswordVisible
                                      ? Icon(Icons.visibility_outlined)
                                      : Icon(Icons.visibility_off_outlined),
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Confirm Password",
                              labelStyle: GoogleFonts.raleway(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(17)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              errorStyle: TextStyle(height: 0.2),
                            ),
                            validator: (value) =>
                                RegisterValidations.validateConfirmPassword(
                                    value, _passwordController.text)),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: Size(344, 55)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final registration =
                                  Provider.of<UserRegistrationProvider>(context,
                                      listen: false);

                              RegistartionEntities? response =
                                  await registration.registeruser(
                                      _nameController.text,
                                      _emailController.text,
                                      _mobileController.text,
                                      _designationController.text,
                                      _passwordController.text);

                              if (response != null && response.status == 1) {
                                context.pushNamed("qrscanner");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(response.message ?? "")));
                              } else {
                                _showErrorDialog(response!.message ?? "");
                              }
                            }
                          },
                          child: Text('Register',
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
