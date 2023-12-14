// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:raqi/src/models/articles/article_model.dart';

class ArticleApiRespons {
  String? status;
  int? totalResults;
  List<ArticleModel>? articles;
  ArticleApiRespons({
    this.status,
    this.totalResults,
    this.articles,
  });

  ArticleApiRespons copyWith({
    String? status,
    int? totalResults,
    List<ArticleModel>? articles,
  }) {
    return ArticleApiRespons(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResults': totalResults,
      'articles': articles!.map((x) => x.toMap()).toList(),
    };
  }

  factory ArticleApiRespons.fromMap(Map<String, dynamic> map) {
    return ArticleApiRespons(
      status: map['status'] != null ? map['status'] as String : null,
      totalResults:
          map['totalResults'] != null ? map['totalResults'] as int : null,
      articles: map['articles'] != null
          ? List<ArticleModel>.from(
              (map['articles'] as List<dynamic>).map<ArticleModel?>(
                (x) => ArticleModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleApiRespons.fromJson(String source) =>
      ArticleApiRespons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ArticleApiRespons(status: $status, totalResults: $totalResults, articles: $articles)';

  @override
  bool operator ==(covariant ArticleApiRespons other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.totalResults == totalResults &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode ^ articles.hashCode;
}
