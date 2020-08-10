import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:validators/validators.dart";
import "package:todo_list/api/todo_api.dart" as api;
import 'package:todo_list/ui/todo_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await api.login(_email, _password);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoList(),
            )).then((value) {
          setState(() {
            _formKey.currentState.reset();
          });
        });
      } catch (e) {
        print("Login failed: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[700],
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 150, left: 10, right: 10),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  MdiIcons.formatListChecks,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Todo List",
                  style: GoogleFonts.poppins(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 80),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (isEmail(value)) {
                        return null;
                      }
                      return "Enter a valid email address";
                    },
                    onSaved: (newValue) => setState(() {
                      _email = newValue;
                    }),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value.length >= 5) {
                        return null;
                      }
                      return "Password must be at least 5 characters long";
                    },
                    onSaved: (newValue) => setState(() {
                      _password = newValue;
                    }),
                  ),
                  SizedBox(height: 25),
                  FlatButton(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => login(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.indigoAccent[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
