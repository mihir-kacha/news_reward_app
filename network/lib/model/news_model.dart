part of 'model.dart';

abstract interface class NewsDataFields {
  static const String createdAt = 'created_at';
  static const String category = 'category';

}

class NewsModel {
  final String? status;
  final int? totalResults;
  final List<NewsData> results;
  final String? nextPage;

  NewsModel({this.status, this.totalResults, this.results = const [], this.nextPage});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      results: (json['results'] as List?)?.map((e) => NewsData.fromJson(e)).toList() ?? [],
      nextPage: json['nextPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'results': results.map((e) => e.toJson()).toList(),
      'nextPage': nextPage,
    };
  }

  NewsModel copyWith({String? status, int? totalResults, List<NewsData>? results, String? nextPage}) {
    return NewsModel(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
      nextPage: nextPage ?? this.nextPage,
    );
  }
}

class NewsData {
  final String? articleId;
  final String? link;
  final String? title;
  final String? description;
  final String? content;
  final List<String> keywords;
  final List<String> creator;
  final String? language;
  final List<String> country;
  final List<String> category;
  final String? datatype;
  final DateTime? pubDate;
  final String? pubDateTz;
  final DateTime? fetchedAt;
  final String? imageUrl;
  final dynamic videoUrl;
  final String? sourceId;
  final String? sourceName;
  final int? sourcePriority;
  final String? sourceUrl;
  final String? sourceIcon;
  final String? sentiment;
  final String? sentimentStats;
  final String? aiTag;
  final String? aiRegion;
  final String? aiOrg;
  final String? aiSummary;
  final bool? duplicate;

  NewsData({
    this.articleId,
    this.link,
    this.title,
    this.description,
    this.content,
    this.keywords = const [],
    this.creator = const [],
    this.language,
    this.country = const [],
    this.category = const [],
    this.datatype,
    this.pubDate,
    this.pubDateTz,
    this.fetchedAt,
    this.imageUrl,
    this.videoUrl,
    this.sourceId,
    this.sourceName,
    this.sourcePriority,
    this.sourceUrl,
    this.sourceIcon,
    this.sentiment,
    this.sentimentStats,
    this.aiTag,
    this.aiRegion,
    this.aiOrg,
    this.aiSummary,
    this.duplicate,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      articleId: json['article_id'],
      link: json['link'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      keywords: List<String>.from(json['keywords'] ?? []),
      creator: List<String>.from(json['creator'] ?? []),
      language: json['language'],
      country: List<String>.from(json['country'] ?? []),
      category: List<String>.from(json['category'] ?? []),
      datatype: json['datatype'],
      pubDate: json['pubDate'] != null ? DateTime.tryParse(json['pubDate']) : null,
      pubDateTz: json['pubDateTZ'],
      fetchedAt: json['fetched_at'] != null ? DateTime.tryParse(json['fetched_at']) : null,
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      sourceId: json['source_id'],
      sourceName: json['source_name'],
      sourcePriority: json['source_priority'],
      sourceUrl: json['source_url'],
      sourceIcon: json['source_icon'],
      sentiment: json['sentiment'],
      sentimentStats: json['sentiment_stats'],
      aiTag: json['ai_tag'],
      aiRegion: json['ai_region'],
      aiOrg: json['ai_org'],
      aiSummary: json['ai_summary'],
      duplicate: json['duplicate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'link': link,
      'title': title,
      'description': description,
      'content': content,
      'keywords': keywords,
      'creator': creator,
      'language': language,
      'country': country,
      'category': category,
      'datatype': datatype,
      'pubDate': pubDate?.toIso8601String(),
      'pubDateTZ': pubDateTz,
      'fetched_at': fetchedAt?.toIso8601String(),
      'image_url': imageUrl,
      'video_url': videoUrl,
      'source_id': sourceId,
      'source_name': sourceName,
      'source_priority': sourcePriority,
      'source_url': sourceUrl,
      'source_icon': sourceIcon,
      'sentiment': sentiment,
      'sentiment_stats': sentimentStats,
      'ai_tag': aiTag,
      'ai_region': aiRegion,
      'ai_org': aiOrg,
      'ai_summary': aiSummary,
      'duplicate': duplicate,

      /// Firebase metadata
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  NewsData copyWith({
    String? articleId,
    String? link,
    String? title,
    String? description,
    String? content,
    List<String>? keywords,
    List<String>? creator,
    String? language,
    List<String>? country,
    List<String>? category,
    String? datatype,
    DateTime? pubDate,
    String? pubDateTz,
    DateTime? fetchedAt,
    String? imageUrl,
    dynamic? videoUrl,
    String? sourceId,
    String? sourceName,
    int? sourcePriority,
    String? sourceUrl,
    String? sourceIcon,
    String? sentiment,
    String? sentimentStats,
    String? aiTag,
    String? aiRegion,
    String? aiOrg,
    String? aiSummary,
    bool? duplicate,
  }) {
    return NewsData(
      articleId: articleId ?? this.articleId,
      link: link ?? this.link,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      keywords: keywords ?? this.keywords,
      creator: creator ?? this.creator,
      language: language ?? this.language,
      country: country ?? this.country,
      category: category ?? this.category,
      datatype: datatype ?? this.datatype,
      pubDate: pubDate ?? this.pubDate,
      pubDateTz: pubDateTz ?? this.pubDateTz,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      sourcePriority: sourcePriority ?? this.sourcePriority,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      sourceIcon: sourceIcon ?? this.sourceIcon,
      sentiment: sentiment ?? this.sentiment,
      sentimentStats: sentimentStats ?? this.sentimentStats,
      aiTag: aiTag ?? this.aiTag,
      aiRegion: aiRegion ?? this.aiRegion,
      aiOrg: aiOrg ?? this.aiOrg,
      aiSummary: aiSummary ?? this.aiSummary,
      duplicate: duplicate ?? this.duplicate,
    );
  }
}
