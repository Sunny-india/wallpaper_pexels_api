class DataPhoto {
  int? page, per_page;
  List<Photo>? photos;
  String? next_page;
  DataPhoto({this.page, this.per_page, this.photos, this.next_page});
  factory DataPhoto.fromJson(Map<String, dynamic> json) {
    List<Photo> insidePhotos = [];
    List<dynamic> photos = json['photos'];
    for (var photo in photos) {
      insidePhotos.add(Photo.fromJson(photo));
    }
    return DataPhoto(
        page: json['page'],
        per_page: json['per_page'],
        next_page: json['next_page'],
        photos: insidePhotos);
  }
}

class Photo {
  int? id, width, height, photographer_id;
  String? url, photographer, photographer_url, avg_color, alt;
  SrcModel? src;
  bool? liked;
  Photo(
      {this.id,
      this.width,
      this.height,
      this.url,
      this.photographer,
      this.photographer_url,
      this.photographer_id,
      this.avg_color,
      this.alt,
      this.src,
      this.liked});

  factory Photo.fromJson(Map<String, dynamic> json) {
    SrcModel src = SrcModel.fromJson(json['src']);
    return Photo(
        id: json['id'],
        width: json['width'],
        height: json['height'],
        url: json['url'],
        photographer: json['photographer'],
        photographer_url: json['photographer_url'],
        photographer_id: json['photographer_id'],
        avg_color: json['avg_color'],
        alt: json['alt'],
        src: src,
        liked: json['liked']);
  }
}

class SrcModel {
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;

  SrcModel(
      {this.landscape,
      this.large,
      this.large2x,
      this.medium,
      this.original,
      this.portrait,
      this.small,
      this.tiny});

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(
        landscape: json['landscape'],
        large: json['large'],
        large2x: json['large2x'],
        medium: json['medium'],
        original: json['original'],
        portrait: json['portrait'],
        small: json['small'],
        tiny: json['tiny']);
  }
}
