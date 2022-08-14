import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  // Custom Props
  final String? labelText;

  // Text Field Props
  final bool autoFocus;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  // Text Field Actions
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;

  const OutlinedTextField(
      {Key? key,
      // Custom Props
      this.labelText,

      // Text Field Props
      this.autoFocus = false,
      this.controller,
      this.keyboardType,

      // Text Field Actions
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label:
            (labelText == null || labelText!.isEmpty) ? null : Text(labelText!),
      ),
      autofocus: autoFocus,
      keyboardType: keyboardType,
      maxLines: 2,
      onChanged: onChanged,
      // Đây là các callback được gọi trên các hành động như khi người dùng nhấp vào nút "Done" button trên bàn phím iOS.
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
    );
  }
}

class OutlinedDecoration extends InputDecoration {
  final String? textLabel;
  const OutlinedDecoration({this.textLabel})
      : super(border: const OutlineInputBorder(), labelText: textLabel);
}
