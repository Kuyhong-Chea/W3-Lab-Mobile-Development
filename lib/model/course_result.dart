class CourseResult {
  String id;
  String studentId;
  String courseId;
  int score;

  CourseResult({
    required this.id, 
    required this.score, 
    required this.studentId,
    required this.courseId
  });
}