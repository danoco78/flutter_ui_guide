import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final void Function(String) onChanged;
  final String label, hint, defaultValue;
  final IconData icon;
  final bool obscureText;
  final FocusNode focusNode;
  final void Function(String)? onSubmitted;

  const MyTextField(
      {
        Key? key,
        required this.onChanged,
        this.label = "",
        this.hint = "",
        required this.icon,
        this.obscureText = false, 
        required this.defaultValue, 
        required this.focusNode, 
        this.onSubmitted,
      })
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _hasFocus = false, _obscureText = true;
  late FocusNode _focusNode;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode;
    _obscureText = widget.obscureText;
    _controller.text = widget.defaultValue;

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      print(_controller.text);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _color = _hasFocus ? Colors.orange[800] : Colors.blue;
    return TextField(
      keyboardType: TextInputType.text,
      autocorrect: false, // deshabilitar el autocorrector
      readOnly: false, // para volverlo de solo lectura
      obscureText: _obscureText, // campos contraseña
      //obscuringCharacter: "?",
      //maxLines: null, // varias lineas automatico
      controller: _controller,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
      focusNode: _focusNode,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: _color,
          ),
          suffixIcon: widget.obscureText
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(_obscureText? Icons.visibility: Icons.visibility_off),
                )
              : TextButton(
                  onPressed: () {
                    _controller.text = '';
                  },
                  child: Icon(Icons.clear_rounded),
                ),
          labelText: widget.label,
          labelStyle: TextStyle(color: _color),
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          )),
      onChanged: widget.onChanged,
    );
  }
}
