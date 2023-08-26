// ignore_for_file: non_constant_identifier_names, duplicate_ignore

class Photosmodel {
  String imgSrc;
  String PhotoName;

  Photosmodel({
    required this.PhotoName,
    required this.imgSrc,
  });

  // ignore: non_constant_identifier_names
  static FromAPI2App(Map<String, dynamic> PhotoMap) {
    return Photosmodel(
        PhotoName: PhotoMap["photographer"],
        imgSrc: (PhotoMap["src"])["portrait"]);
  }
}
