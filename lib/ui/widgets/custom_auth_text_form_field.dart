import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:logger/logger.dart';

class CustomAuthTextFormField extends StatefulWidget {
  final String text;
  final bool obscureText;
  final funValidator;
  final TextEditingController controller;

  const CustomAuthTextFormField({
    Key? key,
    required this.text,
    this.obscureText = false,
    required this.funValidator,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomAuthTextFormField> createState() => _CustomAuthTextFormFieldState();
}

class _CustomAuthTextFormFieldState extends State<CustomAuthTextFormField> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        const SizedBox(height: smallGap),
        SingleChildScrollView(
          controller: _scrollController,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.funValidator,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              hintText: "Enter ${widget.text}",
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
        ),
        KeyboardVisibilityBuilder(
          builder: (context, isVisible) {
            Logger().d("Keyboard Visibility: $isVisible");
            if (isVisible) {
              Logger().d("키보드 보이네?");
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500), // 스크롤 애니메이션 지속 시간
                curve: Curves.ease, // 애니메이션 효과
              );
              Logger().d("화면이 올라갔나요? ${_scrollController.position.maxScrollExtent}");
            } else {
              Logger().d("키보드 안보이네?");
              _scrollController.animateTo(
                0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              Logger().d("화면이 내려갔나요? ${_scrollController.position}");
              Logger().d("화면이 아래로");
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
