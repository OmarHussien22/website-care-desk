import '../../../core/network_structure/params/params.dart';

import '../../../core/routers/app_routes.dart';

class FetchExamConfigParams extends Params {
  ExamTypeEnum? examType;
  int? id;

  FetchExamConfigParams({this.examType, this.id});

  @override
  Map<String, dynamic> toJson() {
    return {
      'exam_id': id,
      'exam_type': examType?.id,
    };
  }
}

enum    ExamTypeEnum {
  testBank(page: AppRoutes.testBankQuestionsPage, id: 6),
  tryTestBank(page: AppRoutes.testBankQuestionsPage, id: 6),
  placementExam(page:AppRoutes.placementQuestionsPage, id: 10),
  placementCustomizedExam(page:AppRoutes.placementQuestionsPage, id: 10),
  courseExam(page: AppRoutes.examQuestionsPage, id: 11);
/*
   case COURSE = 1;
    case UNIT = 2;
    case LESSON = 3;
    case SESSION = 4;
    case BOOK = 5;
    case QUESTION_BANK = 6;
    case QUESTION = 7; // question course exam
    case BOOK_ATTACHMENT = 8;
    case QUESTION_QUESTION_BANK = 9;
    case SELF_EXAM = 10;
    case TEACHER_EXAM = 11;
 */
  final String page;
  final int  id;

  const ExamTypeEnum({required this.page,required this.id,});
}
