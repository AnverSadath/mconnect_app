import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mconnect_app/data/models/onsite_request_model.dart';
import 'package:mconnect_app/data/models/support_request_model.dart';
import 'package:mconnect_app/presentation/logic/provider/onsite_request_provider.dart';
import 'package:mconnect_app/presentation/logic/provider/support_request_provider.dart';
import 'package:mconnect_app/utils/validations/support_request_validations.dart';
import 'package:provider/provider.dart';

class OnsiteRequestPage extends StatefulWidget {
  const OnsiteRequestPage({super.key});

  @override
  State<OnsiteRequestPage> createState() => _OnsiteRequestPageState();
}

class _OnsiteRequestPageState extends State<OnsiteRequestPage> {
  TextEditingController _orgNameController = TextEditingController();
  TextEditingController _contPersonController = TextEditingController();
  TextEditingController _contNumberController = TextEditingController();
  TextEditingController _productTypeController = TextEditingController();
  TextEditingController _summerizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedValue = 1;

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

  void _clearFeild() {
    _orgNameController.clear();
    _contPersonController.clear();
    _contNumberController.clear();
    _summerizeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              "Onsite Request",
              style: GoogleFonts.raleway(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.00500),
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
                            controller: _orgNameController,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Organization Name",
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
                                SupportRequestValidations.validateCompanyName(
                                    value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0150,
                        ),
                        TextFormField(
                            controller: _contPersonController,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Contact Person",
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
                                SupportRequestValidations.validateContactPerson(
                                    value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0150,
                        ),
                        TextFormField(
                            controller: _contNumberController,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              labelText: "Contact Number",
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
                                SupportRequestValidations.validateContactNumber(
                                    value)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0150,
                        ),
                        TextFormField(
                          controller: _productTypeController,
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            filled: true,
                            labelText: "Product Type",
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
                          // validator: (value) =>
                          //     SupportRequestValidations.validateContactPerson(value)
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0150,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Summerize the problem",
                            style: GoogleFonts.raleway(
                                fontSize: 15,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(17)),
                          height: 130,
                          width: 345,
                          child: TextFormField(
                              maxLines: 5,
                              controller: _summerizeController,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(17)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
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
                                  SupportRequestValidations.validateSummary(
                                      value)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0150,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: Size(345, 55),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final onsitetRequest =
                                  Provider.of<OnsiteRequestProvider>(context,
                                      listen: false);

                              OnsiteRequestDtos? response =
                                  await onsitetRequest.onsiteRequest(
                                      _orgNameController.text,
                                      _contPersonController.text,
                                      _contNumberController.text,
                                      _summerizeController.text);

                              if (response != null && response.status == 1) {
                                _clearFeild();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(response.message ?? "")));
                              } else {
                                _showErrorDialog(response!.message ?? "");
                              }
                            }
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.raleway(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
