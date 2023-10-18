import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:logger/logger.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final funValidator;
  final TextEditingController controller;
  final String? initValue;

  const CustomTextFormField({
    Key? key,
    required this.hint,
    this.obscureText = false,
    required this.funValidator,
    required this.controller,
    this.initValue = "",
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  void scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initValue != null) {
      widget.controller.text = widget.initValue!;
    }
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          validator: widget.funValidator,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: "Enter ${widget.hint}",
            enabledBorder: OutlineInputBorder(
              // 3. 기본 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              // 4. 손가락 터치시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              // 5. 에러발생시 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // 5. 에러가 발생 후 손가락을 터치했을 때 TextFormField 디자인
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        KeyboardVisibilityBuilder(builder: (context, isVisible) {
          if (isVisible) {
            Logger().d("키보드 올라옴");
            scrollToBottom();
          } else {
            Logger().d("키보드 내려감");
            scrollToTop();
          }
          return SizedBox();
        }),
      ],
    );
  }
}
