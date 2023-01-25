
class VideoModel {
  VideoModel({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.duration,
    this.uploadTime,
    this.views,
    this.author,
    this.videoUrl,
    this.description,
    this.subscriber,
    this.isLive,
  });

  String? id;
  String? title;
  String? thumbnailUrl;
  String? duration;
  String? uploadTime;
  String? views;
  String? author;
  String? videoUrl;
  String? description;
  String? subscriber;
  bool? isLive;

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json["id"],
      title: json["title"],
      thumbnailUrl: json["thumbnailUrl"],
      duration: json["duration"],
      uploadTime: json["uploadTime"],
      views: json["views"],
      author: json["author"],
      videoUrl: json["videoUrl"],
      description: json["description"],
      subscriber: json["subscriber"],
      isLive: json["isLive"],
    );
  }

}
