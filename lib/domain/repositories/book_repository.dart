import 'package:dartz/dartz.dart';
import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';
import 'package:farm_fresh_shop_app/domain/failures/book_failure.dart';

abstract class BookRepository {
  Future<Either<BookFailure, List<BookEntity>>> getBooks();
}
