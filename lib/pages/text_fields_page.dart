import 'package:flutter/material.dart';
import 'package:flutter_ui_guide/widgets/my_text_field.dart';

class TextFieldsPage extends StatefulWidget {
  const TextFieldsPage({Key? key}) : super(key: key);

  @override
  _TextFieldsPageState createState() => _TextFieldsPageState();
}

class _TextFieldsPageState extends State<TextFieldsPage> {
  String _email = '', _password = '', _company = '';
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeCompany = FocusNode();

  void _submit() {
    print("email $_email");
    print("password $_password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TextFields",
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          // para poder ocultar el teclado tocando la pantalla
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            color: Colors
                .transparent, // obligatorio para que GestureDetector funcione
            child: Column(
              children: [
                MyTextField(
                    icon: Icons.email,
                    label: "Email",
                    hint: "email@domain.com",
                    obscureText: false,
                    defaultValue: "",
                    focusNode: _focusNodeEmail,
                    onChanged: (String texto) {
                      _email = texto;
                    },
                    onSubmitted: (_)=> _focusNodePassword.requestFocus(),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  icon: Icons.lock,
                  label: "Password",
                  obscureText: true,
                  defaultValue: "",
                  focusNode: _focusNodePassword,
                  onChanged: (String texto) {
                    _password = texto;
                  },
                  onSubmitted: (_)=> _focusNodeCompany.requestFocus(),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  onChanged: (String texto) {
                    _company = texto;
                  },
                  icon: Icons.house,
                  label: "Empresa",
                  obscureText: false,
                  defaultValue: "MyPyme",
                  focusNode: _focusNodeCompany,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.send),
                  label: Text("Send"),
                  onPressed: this._submit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
