import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phoneNo;

  @HiveField(3)
  final String ageStudent;

  @HiveField(4)
  final String locationStudent;

  @HiveField(5)
  final String photo;

  StudentModel({
    required this.name,
    required this.phoneNo,
    required this.ageStudent,
    required this.locationStudent,
    required this.id,
    required this.photo,
  });
}