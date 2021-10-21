import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  Function? function,
  required String text,
}) {
  return Container(
    width: width,
    height: 45.0,
    child: MaterialButton(
      onPressed: function!(),
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    ),
  );
}

TextFormField defaultFormFieldF({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData iconPrefix,
  IconData? suffix,
  FocusNode? focusNodes,
  required Function suffixPress,
  required Function onSubmit,
  required Function onChanged,
  required GestureTapCallback onTab,
  bool isPassword = false,
  bool isClicked = true,
  bool autoFocused = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    enabled: isClicked,
    autofocus: autoFocused,
    focusNode: focusNodes,
    validator: validate,
    onTap: onTab,
    onChanged: onChanged(),
    obscureText: isPassword,
    onFieldSubmitted: onSubmit(),
    decoration: InputDecoration(
      label: Text(label),
      prefixIcon: Icon(iconPrefix),
      suffix: Icon(suffix),
      suffixIcon: suffixPress(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}
