class BookEntity {
  final String? title;
  final String? author;
  final String? image;
  final String? aboutAuthor;
  final String? overview;
  final String? bookText;
  final double? price;
  final int quantity;

  BookEntity({
    this.title,
    this.author,
    this.image,
    this.aboutAuthor,
    this.overview,
    this.bookText,
    this.price,
    this.quantity = 1,
  });

  BookEntity.empty()
      : title = "",
        author = "",
        image = "",
        aboutAuthor = "",
        overview = "",
        bookText = "",
        quantity = 1,
        price = 0.0;

  BookEntity copyWith({
    String? title,
    String? author,
    String? image,
    String? aboutAuthor,
    String? overview,
    String? bookText,
    double? price,
    int? quantity,
  }) {
    return BookEntity(
      title: title ?? this.title,
      aboutAuthor: aboutAuthor ?? this.aboutAuthor,
      author: author ?? this.author,
      image: image ?? this.image,
      overview: overview ?? this.overview,
      bookText: bookText ?? this.bookText,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
