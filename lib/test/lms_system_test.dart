import 'package:test/test.dart';

import '../service/lms_system.dart';

void main() {
  test('creates a student', () {
    final lms = LmsSystem();

    // Create a student
    lms.addStudent(studentId: 'S1', studentName: "ronan");

    expect(lms.students.first.name, 'ronan');

    // Remove the student
    lms.removeStudent(studentId: 'S1');
    expect(lms.students.length, 0);
  });

  test('Creates a course', () {
    final lms = LmsSystem();

    lms.addCourse(courseId: '001', courseName: 'Fashion merchandise');
    expect(lms.courses.length, 1);
    expect(lms.courses[0].id, '001');
  });

  test('Enroll a student', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: "Kuyhong");

    lms.addCourse(courseId: '001', courseName: 'Merchandise');

    lms.enrollStudent(studentId: 'S1', courseId: '001');
    expect(lms.courses[0].studentIds[0], 'S1');

    lms.enrollStudent(studentId: 'S1', courseId: '001');
    lms.enrollStudent(studentId: 'S2', courseId: '001');
    lms.enrollStudent(studentId: 'S1', courseId: '002');
  });

  test('Remove a student from a course', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: "Kuyhong");

    lms.addCourse(courseId: '001', courseName: 'Merchandise');

    lms.enrollStudent(studentId: 'S1', courseId: '001');
    lms.addScore(studentId: 'S1', courseId: '001', studentScore: 80, resultId: 'R1');
    expect(lms.results.length, 1);
    lms.discardStudentFromCourse(studentId: 'S1', courseId: '001');
    expect(lms.courses[0].studentIds.length, 0);
    expect(lms.results.length, 0);
  });

  test('Add a score', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: "Kuyhong");

    lms.addCourse(courseId: '001', courseName: 'Merchandise');
    lms.enrollStudent(studentId: 'S1', courseId: '001');

    lms.addScore(studentId: 'S1', courseId: '001', studentScore: 80, resultId: 'R1');
  });

  test('Remove a score', () {
    final lms = LmsSystem();

    lms.addStudent(studentId: 'S1', studentName: "Kuyhong");

    lms.addCourse(courseId: '001', courseName: 'Merchandise');
    lms.enrollStudent(studentId: 'S1', courseId: '001');

    lms.addScore(studentId: 'S1', courseId: '001', studentScore: 80, resultId: 'R1');
    lms.removeScore(resultId: 'R1');
    expect(lms.results.length, 0);
  });
 }
