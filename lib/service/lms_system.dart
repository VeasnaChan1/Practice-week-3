
import '../model/student.dart';
import '../model/course.dart';
import '../model/result.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses = [];
  final List<Result> results =[];
  
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
    //remove student from enrollment 
    for(var c in courses){
      c.studentIds.removeWhere((s)=>s==studentId);
    }
    //remove student for result
    results.removeWhere((result)=> result.studentId == studentId);
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);
 
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  } 

  Result? _findResultOrNull(String studentId, String courseId) {
    for (Result r in results) {
      if (r.studentId == studentId && r.courseId==courseId ) {
        return r;
      }
    }
    return null; // not found
  } 

  Course? _findCourseOrNull(String courseId){
    for(Course course in courses){
      if(course.id == courseId){
        return course;
      }
    }
    return null; // course not found
  }


  // add and remove courses
  void addCourse({required String courseId, required String courseName}){
    Course? course = _findCourseOrNull(courseId);
    if(course!= null){
      throw Exception('Course with id $courseId already exist');
    }
    Course newCourse = Course(id: courseId, name: courseName);
    courses.add(newCourse);
  }

  // remove course
   void removeCourse({required courseId}){
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception('Course ID $courseId not found');
    }
    // remove course
    courses.removeWhere((course)=> course.id== courseId);
   }

  void enrollStudent({required String studentId,required String courseId}){
    //student exist
    Student? student = _findStudentOrNull(studentId);
    if(student == null){
      throw Exception("Student does not exist");
    }
    // course exist
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception("Course does not exist");
    }
    // student not enrolled in the course
    bool enroll= course.studentIds.any((student)=>student == studentId);
    if(enroll){
      throw Exception("Student is already registered in the course");
    }

    course.studentIds.add(studentId);  
  } 

  void discardStudentFromCourse({required String studentId, required String courseId}){
        //student exist
    Student? student = _findStudentOrNull(studentId);
    if(student == null){
      throw Exception("Student does not exist");
    }
    // course exist
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception("Course does not exist");
    }
    // student not exist in the course
    bool enroll= course.studentIds.any((student)=>student == studentId);
    if(!enroll){
      throw Exception("Student not enrolled in the course");
    }
    course.studentIds.removeWhere((s)=>s==studentId);
  }

  void addResult({required studentId, required courseId, required List<int> score}){
    bool invalidScore = score.any((s)=>s<0 || s>100);
    if(invalidScore) throw Exception("Invalid score");
    //student exist

    Student? student = _findStudentOrNull(studentId);
    if(student == null){
      throw Exception("Student does not exist");
    }
    // course exist
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception("Course does not exist");
    }
    // student not exist in the course
    bool enroll= course.studentIds.any((student)=>student == studentId);
    if(!enroll){
      throw Exception("Student not enrolled in the course");

    }
    Result newResult = Result (studentId: studentId, courseId: courseId, score: score);
    results.add(newResult);
  }

  void removeResult({required String studentId, required String courseId}){
    // the result must exsist 
        Student? student = _findStudentOrNull(studentId);
    if(student == null){
      throw Exception("Student does not exist");
    }
    // course exist
    Course? course = _findCourseOrNull(courseId);
    if(course == null){
      throw Exception("Course does not exist");
    }

    Result? result = _findResultOrNull(studentId, courseId);
    if(result == null){
      throw Exception("The result does not exist");
    }
    results.removeWhere((result)=> result.studentId == studentId && result.courseId== courseId);
  }

}
