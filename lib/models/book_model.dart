class BookModel {
  String? author;
  String? bookName;
  String? category;
  String? coverImageUrl;
  String? description;
  String? pageNumber;
  String? releaseDate;
  String? bookId;
  String? pdfUrl;

  BookModel(
      {this.author,
      this.bookName,
      this.category,
      this.coverImageUrl,
      this.description,
      this.pageNumber,
      this.releaseDate,
      this.bookId,
      this.pdfUrl});

  BookModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    bookName = json['bookName'];
    category = json['category'];
    coverImageUrl = json['coverImageUrl'];
    description = json['description'];
    pageNumber = json['pageNumber'];
    releaseDate = json['releaseDate'];
    bookId = json['bookId'];
    pdfUrl = json['pdfUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['bookName'] = bookName;
    data['category'] = category;
    data['coverImageUrl'] = coverImageUrl;
    data['description'] = description;
    data['pageNumber'] = pageNumber;
    data['releaseDate'] = releaseDate;
    data['bookId'] = bookId;
    data['pdfUrl'] = pdfUrl;
    return data;
  }
}
