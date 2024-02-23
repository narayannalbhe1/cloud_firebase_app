import 'package:flutter/material.dart';

class UiHelper {

  static Widget customTextField({
      required TextEditingController controller,
      required String hintText,
      required Icon icon,
      required TextInputType keyboardType,
      required FormFieldValidator<String> validator,
      bool obscureText = false,
    }) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              obscureText: obscureText,
              // focusNode: _emailFocusNode,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: icon,
                border: InputBorder.none,
              ),
              autofocus: true,
              cursorColor: Colors.transparent,
              keyboardType: keyboardType,
              validator: validator,
            ),
          ),
        ),
      );
    }

  static Widget RoundButton(VoidCallback voidCallback,String text) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
        onPressed: voidCallback,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }



}


