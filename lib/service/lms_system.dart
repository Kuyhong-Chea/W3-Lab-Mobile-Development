import 'package:lms_layered_architecture_example/model/course.dart';
import 'package:lms_layered_architecture_example/model/course_result.dart';
import '../model/student.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<CourseResult> results = [];
 
  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }
 
 
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);

    for (Course c in courses){
      for (String s_id in c.studentIds){
        if (s_id == studentId){
          c.studentIds.remove(s_id);
        }
      }
    }

    for (CourseResult r in results){
      if (r.studentId == studentId){
        results.remove(r);
      }
    }
    return;
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  } 

  void addCourse({required String courseId, required String courseName}) {
    Course newCourse = Course(id: courseId, name: courseName);
    courses.add(newCourse);
  }

  Course? _findCourseOrNull(String courseId) {
    for (Course c in courses){
      if (c.id == courseId){
        return c;
      }
    }
    return null;
  }

  void enrollStudent({required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null){
      throw Exception('Student $studentId not found.');
    }
    Course? course = _findCourseOrNull(courseId);
    if (course == null){
      throw Exception('Course $courseId not found');
    }
    for (String s_id in course.studentIds){
      if (s_id == studentId){
        throw Exception('Student is already enrolled in this course.');
      }
    }

    course.studentIds.add(studentId);
  }

  void discardStudentFromCourse({required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null){
      throw Exception('Student $studentId not found.');
    }
    Course? course = _findCourseOrNull(courseId);
    if (course == null){
      throw Exception('Course $courseId not found');
    }
    if (_findStudentInCourse(studentId: studentId, courseId: courseId) == false){
      throw Exception('Student $studentId is not enrolled in course $courseId.');
    }

    course.studentIds.remove(studentId);

    for (int i = results.length - 1; i >= 0; i--){
      if (results[i].studentId == studentId && results[i].courseId == courseId){
        results.removeAt(i);
      }
    }
  }

  bool _findStudentInCourse({required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null){
      throw Exception('Student $studentId not found.');
    }
    Course? course = _findCourseOrNull(courseId);
    if (course == null){
      throw Exception('Course $courseId not found');
    }
    for (String s_id in course.studentIds){
      if (s_id == studentId){
        return true;
      }
    }
    return false;
  }

  void addScore({required String studentId, required String courseId, required int studentScore, required String resultId}){
    Student? student = _findStudentOrNull(studentId);
    if (student == null){
      throw Exception('Student $studentId not found.');
    }

    Course? course = _findCourseOrNull(courseId);
    if (course == null){
      throw Exception('Course $courseId not found');
    }

    if (_findStudentInCourse(studentId: studentId, courseId: courseId) == false){
      throw Exception('Student $studentId is not enrolled in this course');
    }

    if (studentScore < 0 || studentScore > 100){
      throw Exception('Score is out of range.');
    }

    for (CourseResult r in results){
      if (r.studentId == studentId && r.courseId == courseId){
        throw Exception('Student score for this course already exists.');
      }
    }

    for (String id in course.studentIds){
      if (id == studentId){
        CourseResult score = CourseResult(id: resultId, courseId: courseId, studentId: studentId, score: studentScore);
        results.add(score);
      } else {
        return;
      }
    }
  }

  void removeScore({required String resultId}) {
    for (CourseResult r in results){
      if (r.id == resultId){
        results.remove(r);
        return;
      }
    }
    throw Exception('Result does not exist');
  }
}
