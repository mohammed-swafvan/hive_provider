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
        placeholderStyle: TextStyle(color: kWhiteColorOpacity5),
        style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.all(12),
        prefixIcon: Icon(
          Icons.search,
          color: kWhiteColorOpacity5,
        ),
        suffixIcon: Icon(
          Icons.close,
          color: kWhiteColorOpacity5,
        ),
        backgroundColor: kWhiteColor.withOpacity(0.2),
        onChanged: (value) {
          Provider.of<StudentProvider>(context, listen: false).runFilter(value);
        },
      ),
    );
  }
}
