import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function(String value) callback;
  const SearchWidget({super.key, required this.callback});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController textEditController = TextEditingController();
  @override
  void initState() {
    //
    super.initState();
  }

  @override
  void dispose() {
    textEditController.dispose();
//
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: TextField(
          controller: textEditController,
          onChanged: (val) {
            widget.callback(textEditController.text);
          },
          cursorHeight: 13,
          style: const TextStyle(height: 1, fontSize: 13, color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.25),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF979797),
            ),
            contentPadding: const EdgeInsets.only(top: 0),
            hintText: 'Search',
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFF979797),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none),
          )),
    );
  }
}
