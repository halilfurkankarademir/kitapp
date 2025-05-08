import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get_storage/get_storage.dart';

class ReadBookPage extends StatefulWidget {
  const ReadBookPage({super.key, this.bookId, this.pdfUrl, this.bookName});

  final String? bookId;
  final String? pdfUrl;
  final String? bookName;

  @override
  State<ReadBookPage> createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  int currentPageNumber = 0;
  int totalPageNumber = 0;
  final pageController = TextEditingController();

  PDFViewController? pdfController;
  final GetStorage box = GetStorage();

  void saveCurrentPageNumberAndQuit() async {
    // Use get storage to save remaining page number for each book
    box.write(widget.bookId!, totalPageNumber - currentPageNumber);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void goToPage(int page) async {
    pdfController?.setPage(page);
    setState(() {
      currentPageNumber = page;
    });
  }

  void getCurrentPageNumber() async {
    final remaining = box.read(widget.bookId!) as int;
    final number = totalPageNumber - remaining;
    setState(() {
      currentPageNumber = number;
      pageController.text = number.toString();
    });
    //Go to the page which user red last.
    goToPage(currentPageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.bookName ?? 'Kitap Adı',
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            saveCurrentPageNumberAndQuit();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 30,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: TextField(
                    controller: pageController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onChanged: (value) {
                      goToPage(int.parse(value));
                    },
                  ),
                ),
                Text(
                  '/ $totalPageNumber',
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: PDF(
        onRender: (pages) {
          getCurrentPageNumber();
        },
        onViewCreated: (controller) {
          pdfController = controller;
          pdfController?.setPage(currentPageNumber);
        },
        onPageChanged: (page, total) {
          setState(() {
            currentPageNumber = page!;
            totalPageNumber = total!;
            pageController.text = page.toString();
          });
        },
      ).cachedFromUrl(
        widget.pdfUrl!,
        placeholder: (progress) => Center(
            child: Text(
          '$progress %',
          style: const TextStyle(fontFamily: 'Poppins'),
        )),
        errorWidget: (error) => const Center(
          child: Text(
            'Kitap bulunamadı :(',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
