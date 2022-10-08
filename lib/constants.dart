import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kInputDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key, required this.hint, required this.textInputType});

  final String hint;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: TextField(
            keyboardType: textInputType,
            cursorColor: Colors.red,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            decoration: kInputDecoration.copyWith(hintText: hint)));
  }
}

getSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.black,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(15),
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

loading() {
  Get.dialog(const Center(
    child: CircularProgressIndicator(color: Colors.white),
  ));
}

