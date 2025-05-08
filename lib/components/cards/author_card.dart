import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({
    super.key,
    required this.authorName,
    required this.authorImageUrl,
    required this.authorId,
  });

  final String authorName;
  final String authorImageUrl;
  final String authorId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'AuthorDetailsPage', arguments: authorId);
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              authorImageUrl,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            authorName,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
