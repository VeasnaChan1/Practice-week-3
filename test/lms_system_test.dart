import 'package:test/test.dart';

import '../lib/service/lms_system.dart';

void main() {
  test('creates a student', () {
    // Create a student
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "ronan");

    expect(lms.students.first.name, 'ronan');

    // Remove the student
    lms.removeStudent(studentId: 'S1');
    expect(lms.students.length, 0);
  });

  test('Add a course', () {
    // create a course
      final lms = LmsSystem();
    lms.addCourse(courseId: "CO1", courseName: "Mobile Development");
    expect(lms.courses.first.name, 'Mobile Development');
  });
// add a duplicated course
  test('Add a duplicated courses', () {
    // create a course
      final lms = LmsSystem();
    lms.addCourse(courseId: 'CO1', courseName: "Mobile");
    expect(() => lms.addCourse(courseId: "CO1", courseName: "Algorithm"),
        throwsException);
  });

  test('remove a course', () {
    // create a course
      final lms = LmsSystem();
    lms.addCourse(courseId: "CO1", courseName: "Mobile Development");
    lms.addCourse(courseId: "CO2", courseName: "Algorithm");
    lms.removeCourse(courseId: "CO2");
    expect(lms.courses.length, 1);
  });

  test("Remove non-existent course", () {
      final lms = LmsSystem();
    lms.addCourse(courseId: "CO1", courseName: "Mobile Development");
    expect(() => lms.removeCourse(courseId: "CO3"), throwsException);
  });

  test("enroll existing student to an existing course", () {
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    expect(lms.courses[0].studentIds[0], 'S1');
  });

  test("Reject enrollment if student does not exist", () {
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    expect(() => lms.enrollStudent(courseId: 'CO1', studentId: 'S2'),
        throwsException);
  });

  test("Reject enrollment if course does not exist", () {
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    expect(() => lms.enrollStudent(courseId: 'CO2', studentId: 'S1'),
        throwsException);
  });

  test("Reject enrollment if duplicated", () {
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    expect(() => lms.enrollStudent(courseId: 'CO1', studentId: 'S1'),
        throwsException);
  });

  test("Remove existing enrollment", () {
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.discardStudentFromCourse(courseId: 'CO1', studentId: 'S1');
    expect(lms.courses[0].studentIds.length, 0);
  });

    test("Remove existing enrollment", () {
      final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.discardStudentFromCourse(courseId: 'CO1', studentId: 'S1');
    expect(lms.courses[0].studentIds.length, 0);
  });

    test("Reject removal of a non existent enrollment", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    expect(()=>lms.discardStudentFromCourse(courseId: 'CO4', studentId: 'S5'), throwsException);
  });

    test("Verify that the student and course still exist after the enrollment is removed.", () {
       final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.discardStudentFromCourse(courseId: 'CO1', studentId: 'S1');
    expect(lms.students.length, 1);
  });

    test("Test removing student who has enrolled in multiple course", () {
       final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.addCourse(courseId: 'CO2', courseName: 'Algorithm');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.enrollStudent(courseId: 'CO2', studentId: 'S1');
    lms.removeStudent(studentId: 'S1');
    expect(lms.courses[0].studentIds.length, 0);
  });

    test("Add a valid result", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.addResult(studentId:'S1', courseId: 'CO1', score: [98] );
    expect(lms.results.length, 1);
  });

      test("Reject result of non existent students", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    expect(()=>lms.addResult(studentId:'S2', courseId: 'CO1', score: [98] ), throwsException);
  });

        test("Reject student who is not enrolled in the course", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.addStudent(studentId: 'S2', studentName: 'Meyly');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    expect(()=>lms.addResult(studentId:'S2', courseId: 'CO1', score: [98] ), throwsException);
  });

    test("Reject an invalid score", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    expect(()=>lms.addResult(studentId:'S1', courseId: 'CO1', score: [-55] ), throwsException);
  });

      test("Remove an existing result", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.addResult(studentId:'S1', courseId: 'CO1', score: [98] );
    lms.removeResult(studentId: 'S1', courseId: 'CO1');
    expect(lms.results.length, 0);
  });

    test("Reject removal of non existing results", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.addResult(studentId:'S1', courseId: 'CO1', score: [98] );
    expect(()=>lms.removeResult(studentId: 'S1', courseId: 'CO2'), throwsException);
  });

    test("Verify that the result is no longer available", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.addResult(studentId:'S1', courseId: 'CO1', score: [98] );
    lms.removeResult(studentId: 'S1', courseId: 'CO1');
    expect(lms.results.length, 0);
  });

      test("Verify that everything remain unchanged", () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: "Veasna");
    lms.addCourse(courseId: 'CO1', courseName: 'Mobile');
    lms.enrollStudent(courseId: 'CO1', studentId: 'S1');
    lms.addResult(studentId:'S1', courseId: 'CO1', score: [98] );
    lms.removeResult(studentId: 'S1', courseId: 'CO1');
    expect(lms.results.length, 0);
    expect(lms.courses.length, 1);
    expect(lms.students.length, 1);
  });

}
