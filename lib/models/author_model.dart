class AuthorModel {
  String? authorName;
  String? authorImageUrl;
  String? authorId;

  AuthorModel({this.authorName, this.authorImageUrl});

  AuthorModel.fromJson(Map<String, dynamic> json) {
    authorName = json['authorName'];
    authorImageUrl = json['authorImageUrl'];
    authorId = json['authorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorName'] = authorName;
    data['authorImageUrl'] = authorImageUrl;
    data['authorId'] = authorId;
    return data;
  }
}
