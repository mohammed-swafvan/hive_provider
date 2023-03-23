import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/core/constains.dart';
import 'package:student_app/controller/provider/student_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CupertinoSearchTextField(
        placeholderStyle: TextStyle(color: kWhiteColorOpacity8),
        style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.all(10),
        prefixIcon: Icon(
          Icons.search,
          color: kWhiteColorOpacity8,
        ),
        suffixIcon: Icon(
          Icons.close,
          color: kWhiteColorOpacity8,
        ),
        backgroundColor: kWhiteColorOpacity5,
        onChanged: (value) {
          Provider.of<StudentProvider>(context, listen: false).runFilter(value);
        },
      ),
    );
  }
}
