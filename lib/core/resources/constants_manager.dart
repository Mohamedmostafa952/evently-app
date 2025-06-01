import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/data/DM/category_DM.dart';

class ConstantsManager {
  static List<CategoryDM> categories = [
    CategoryDM(
      id: "0",
      categoryName: "All",
      iconPath: SvgAssets.all,
      imagePath: ImageAssets.sports,
    ),
    CategoryDM(
      id: "1",
      categoryName: "Sport",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.sports,
    ),
    CategoryDM(
      id: "2",
      categoryName: "Birthday",
      iconPath: SvgAssets.birthday,
      imagePath: ImageAssets.birthday,
    ),
    CategoryDM(
      id: "3",
      categoryName: "Meeting",
      iconPath: SvgAssets.meeting,
      imagePath: ImageAssets.meeting,
    ),
    CategoryDM(
      id: "4",
      categoryName: "Gaming",
      iconPath: SvgAssets.gaming,
      imagePath: ImageAssets.gaming,
    ),
    CategoryDM(
      id: "5",
      categoryName: "Eating",
      iconPath: SvgAssets.eating,
      imagePath: ImageAssets.eating,
    ),
    CategoryDM(
      id: "6",
      categoryName: "Holiday",
      iconPath: SvgAssets.holiday,
      imagePath: ImageAssets.holiday,
    ),
    CategoryDM(
      id: "7",
      categoryName: "Exhibition",
      iconPath: SvgAssets.exhibition,
      imagePath: ImageAssets.exhibition,
    ),
    CategoryDM(
      id: "8",
      categoryName: "Workshop",
      iconPath: SvgAssets.workshop,
      imagePath: ImageAssets.workshop,
    ),
    CategoryDM(
      id: "9",
      categoryName: "BookClub",
      iconPath: SvgAssets.book,
      imagePath: ImageAssets.bookClub,
    ),
  ];
  static List<CategoryDM> categoriesWithoutAll = [
    CategoryDM(
      id: "1",
      categoryName: "Sport",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.sports,
    ),
    CategoryDM(
      id: "2",
      categoryName: "Birthday",
      iconPath: SvgAssets.birthday,
      imagePath: ImageAssets.birthday,
    ),
    CategoryDM(
      id: "3",
      categoryName: "Meeting",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.meeting,
    ),
    CategoryDM(
      id: "4",
      categoryName: "Gaming",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.gaming,
    ),
    CategoryDM(
      id: "5",
      categoryName: "Eating",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.eating,
    ),
    CategoryDM(
      id: "6",
      categoryName: "Holiday",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.holiday,
    ),
    CategoryDM(
      id: "7",
      categoryName: "Exhibition",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.exhibition,
    ),
    CategoryDM(
      id: "8",
      categoryName: "Workshop",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.workshop,
    ),
    CategoryDM(
      id: "9",
      categoryName: "BookClub",
      iconPath: SvgAssets.sports,
      imagePath: ImageAssets.bookClub,
    ),
  ];
}
