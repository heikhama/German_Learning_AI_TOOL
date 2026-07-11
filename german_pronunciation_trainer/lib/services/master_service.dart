import '../models/language_model.dart';
import '../models/category_model.dart';
import '../models/difficulty_model.dart';
import 'api_service.dart';

class MasterService {

  //--------------------------------------------------------

  static Future<List<LanguageModel>>
      getLanguages() async {

    final result =
        await ApiService.getLanguages();

    final List list =
        result["data"] ?? [];

    return list

        .map(
          (e) =>
              LanguageModel.fromJson(e),
        )

        .toList();

  }

  //--------------------------------------------------------

  static Future<List<CategoryModel>>
      getCategories() async {

    final result =
        await ApiService.getCategories();

    final List list =
        result["data"] ?? [];

    return list

        .map(
          (e) =>
              CategoryModel.fromJson(e),
        )

        .toList();

  }

  //--------------------------------------------------------

  static Future<List<DifficultyModel>>
      getLevels() async {

    final result =
        await ApiService.getDifficultyLevels();

    final List list =
        result["data"] ?? [];

    return list

        .map(
          (e) =>
              DifficultyModel.fromJson(e),
        )

        .toList();

  }

}