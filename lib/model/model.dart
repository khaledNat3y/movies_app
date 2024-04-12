class Film {
  final String title;
  final String overview;
  final String date;
  final String path;
  final String? documentId; // Add the document ID field

  Film({
    required this.title,
    required this.overview,
    required this.date,
    required this.path,
    this.documentId, // Initialize the document ID field
  });
}
