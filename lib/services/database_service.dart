// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:kitapp/models/author_model.dart';
import '../models/book_model.dart';
import 'auth.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final _user = Auth().currentUser;

  //Ref for specific user
  DatabaseReference get _userRef =>
      FirebaseDatabase.instance.ref('users/${_user?.uid}');

  //Ref for all users
  DatabaseReference get _usersRef => FirebaseDatabase.instance.ref('users');

  //Books ref
  DatabaseReference get _bookRef => FirebaseDatabase.instance.ref('books');

  //Author ref
  DatabaseReference get _authorRef => FirebaseDatabase.instance.ref('authors');

  //Carousel ref
  DatabaseReference get _carouselRef =>
      FirebaseDatabase.instance.ref('carousel');

  //Get registered user count
  Future<int> getUsersCount() async {
    try {
      final snapshot = await _usersRef.get();
      if (snapshot.exists) {
        return snapshot.children.length;
      } else {
        print('Kullanıcılar bulunamadı');
        return 0;
      }
    } catch (e) {
      print('Kullanıcı sayısı çekme hatası $e');
      return 0;
    }
  }

  //Get registered book count
  Future<int> getBooksCount() async {
    try {
      final snapshot = await _bookRef.get();
      if (snapshot.exists) {
        return snapshot.children.length;
      } else {
        print('Kitaplar bulunamadı');
        return 0;
      }
    } catch (e) {
      print('Kitap sayısı çekme hatası $e');
      return 0;
    }
  }

  //Get registered author count
  Future<int> getAuthorsCount() async {
    try {
      final snapshot = await _authorRef.get();
      if (snapshot.exists) {
        return snapshot.children.length;
      } else {
        print('Yazarlar bulunamadı');
        return 0;
      }
    } catch (e) {
      print('Yazar sayısı çekme hatası $e');
      return 0;
    }
  }

  //Fetch user data from firebase
  Future<dynamic> getUserData() async {
    try {
      if (_user == null) {
        print('User not logged in.');
        return null;
      }

      final DataSnapshot snapshot = await _userRef.get();
      if (snapshot.exists) {
        return snapshot.value;
      } else {
        print('No data found.');
        return null;
      }
    } catch (e) {
      print('Data retrieval error: $e');
      return null;
    }
  }

  //Save user data at register

  Future<void> saveUserDetails(String username, String email) async {
    try {
      if (_user == null) {
        print('User not logged in.');
        return;
      }
      await _userRef.set({
        'username': username,
        'email': email,
      });
      print('User details saved successfully.');
    } catch (e) {
      print('Error saving user details: $e');
    }
  }

  //Save new book to firebase

  Future<void> saveBook(
      String bookName,
      String author,
      String releaseDate,
      String category,
      String pageNumber,
      String description,
      String coverImageUrl,
      String pdfUrl) async {
    var uuid = const Uuid();
    String bookId = uuid.v4();

    try {
      await _bookRef.child(bookId).set({
        'bookName': bookName,
        'author': author,
        'releaseDate': releaseDate,
        'category': category,
        'pageNumber': pageNumber,
        'description': description,
        'coverImageUrl': coverImageUrl,
        'bookId': bookId,
        'pdfUrl': pdfUrl
      });
    } catch (e) {
      print('Error saving book details: $e');
    }
  }

  //Get all books from database
  Future<List<BookModel>> getAllBooks() async {
    List<BookModel> books = [];

    try {
      final snapshot = await _bookRef.get();
      if (snapshot.exists) {
        final booksData = Map<String, dynamic>.from(snapshot.value as Map);

        booksData.forEach((key, value) {
          books.add(BookModel.fromJson(Map<String, dynamic>.from(value)));
        });
      } else {
        print('Veritabanında kitap bulunamadı.');
      }
    } catch (e) {
      print('Tüm kitapları çekme hatası: $e');
    }

    return books;
  }

  //Get book details by name

  Future<BookModel?> getBookByBookId(String id) async {
    final snapshot =
        await _bookRef.orderByChild('bookId').equalTo(id).limitToFirst(1).get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final firstEntry = data.values.first as Map<dynamic, dynamic>;
      return BookModel.fromJson(Map<String, dynamic>.from(firstEntry));
    } else {
      return null;
    }
  }

  //Delete book by id
  Future<void> deleteBookByBookId(String id) async {
    try {
      await _bookRef.child(id).remove();
    } catch (e) {
      print('Kitap silinme hatası!');
    }
  }

  //Add book to favorites

  Future<void> addFavorites(String bookId, String bookName, String author,
      String category, String coverImageUrl) async {
    try {
      await _userRef.child('favorites').child(bookId).set({
        'bookId': bookId,
        'bookName': bookName,
        'author': author,
        'category': category,
        'coverImageUrl': coverImageUrl
      });
    } catch (e) {
      print('Favorilere ekleme hatası: $e');
    }
  }

  //Check is book in favorites
  Future<bool> isFavorite(String bookId) async {
    try {
      final snapshot = await _userRef.child('favorites').child(bookId).get();
      return snapshot.exists; // Favori varsa true, yoksa false döner
    } catch (e) {
      print('Favori kontrol hatası: $e');
      return false;
    }
  }

  //Get favorite books
  Future<List<BookModel>> getFavoriteBooks() async {
    List<BookModel> favoriteBooks = [];
    final snapshot = await _userRef.child('favorites').get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      for (var value in data.values) {
        final book = BookModel.fromJson(Map<String, dynamic>.from(value));
        favoriteBooks.add(book);
      }
    }
    return favoriteBooks;
  }

  //delete favorite
  Future<bool> deleteFavorite(String bookId) async {
    try {
      await _userRef.child('favorites').child(bookId).remove();
      print('Kitap favorilerden silindi.');
      return true;
    } catch (e) {
      print('Favori silme hatası: $e');
      return false;
    }
  }

  //Add author

  Future<void> addAuthor(String authorName, String authorImageUrl) async {
    var uuid = const Uuid();
    String id = uuid.v4();
    try {
      await _authorRef.child(id).set({
        'authorName': authorName,
        'authorImageUrl': authorImageUrl,
        'authorId': id
      });
    } catch (e) {
      print(e);
    }
  }

  //Remove author by id
  Future<void> deleteAuthorById(String id) async {
    try {
      await _authorRef.child(id).remove();
    } catch (e) {
      print('Failed to delete author: $e');
    }
  }

  //Get all authors
  Future<List<AuthorModel>> getAllAuthors() async {
    List<AuthorModel> authors = [];

    try {
      final snapshot = await _authorRef.get();
      if (snapshot.exists) {
        final authorsData = Map<String, dynamic>.from(snapshot.value as Map);

        authorsData.forEach((key, value) {
          authors.add(AuthorModel.fromJson(Map<String, dynamic>.from(value)));
        });
      } else {
        print('Veritabanında kitap bulunamadı.');
      }
    } catch (e) {
      print('Tüm kitapları çekme hatası: $e');
    }

    return authors;
  }

  //Get author details for the author details page
  Future<AuthorModel?> getAuthorById(String id) async {
    final snapshot = await _authorRef
        .orderByChild('authorId')
        .equalTo(id)
        .limitToFirst(1)
        .get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final firstEntry = Map<String, dynamic>.from(data.values.first as Map);
      return AuthorModel.fromJson(firstEntry);
    } else {
      return null;
    }
  }

  //Get books by category
  Future<List<BookModel>> getBooksByCategory(String category) async {
    final snapshot =
        await _bookRef.orderByChild('category').equalTo(category).get();

    print(snapshot.value);

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      print(data.values);
      return data.values
          .map((bookData) =>
              BookModel.fromJson(Map<String, dynamic>.from(bookData as Map)))
          .toList();
    } else {
      print('hata var');
      return [];
    }
  }

  //Save carousel images
  Future<void> saveCarousel(String url1, String url2, String url3) async {
    try {
      await _carouselRef.set({'image1': url1, 'image2': url2, 'image3': url3});
    } catch (e) {
      print(e);
    }
  }

  //Get carousel images
  Future<List<String>> getCarousel() async {
    final snapshot = await _carouselRef.get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return data.values.map((url) => url as String).toList();
    } else {
      return [];
    }
  }
}
