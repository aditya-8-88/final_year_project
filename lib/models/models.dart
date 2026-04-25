// All data models for the Nagrik app

class ConstitutionArticle {
  final String articleNumber;
  final String title;
  final String description;
  final String simpleExplanation;
  final String part;
  final String partTitle;
  final String category;
  final List<String> keywords;

  const ConstitutionArticle({
    required this.articleNumber,
    required this.title,
    required this.description,
    required this.simpleExplanation,
    required this.part,
    required this.partTitle,
    required this.category,
    this.keywords = const [],
  });
}

class ConstitutionPart {
  final String partNumber;
  final String title;
  final String articleRange;
  final String summary;
  final List<ConstitutionArticle> articles;

  const ConstitutionPart({
    required this.partNumber,
    required this.title,
    required this.articleRange,
    required this.summary,
    required this.articles,
  });
}

class Amendment {
  final int number;
  final String year;
  final String description;
  final String impact;
  final List<String> articlesAffected;

  const Amendment({
    required this.number,
    required this.year,
    required this.description,
    required this.impact,
    this.articlesAffected = const [],
  });
}

class LawCategory {
  final String name;
  final String icon;
  final String description;
  final List<LawSection> sections;

  const LawCategory({
    required this.name,
    required this.icon,
    required this.description,
    required this.sections,
  });
}

class LawSection {
  final String sectionNumber;
  final String title;
  final String actName;
  final String description;
  final String simpleExplanation;
  final String punishment;
  final List<String> keywords;

  const LawSection({
    required this.sectionNumber,
    required this.title,
    required this.actName,
    required this.description,
    required this.simpleExplanation,
    this.punishment = '',
    this.keywords = const [],
  });
}

class GlossaryTerm {
  final String term;
  final String definition;
  final String hindiTerm;
  final String example;

  const GlossaryTerm({
    required this.term,
    required this.definition,
    this.hindiTerm = '',
    this.example = '',
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String category;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.category,
  });
}

class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final String source;

  ChatMessage({
    required this.content,
    required this.isUser,
    DateTime? timestamp,
    this.source = '',
  }) : timestamp = timestamp ?? DateTime.now();
}

class Bookmark {
  final String id;
  final String title;
  final String type;
  final String subtitle;
  final DateTime savedAt;

  Bookmark({
    required this.id,
    required this.title,
    required this.type,
    required this.subtitle,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();

  Map<String, String> toMap() => {
        'id': id,
        'title': title,
        'type': type,
        'subtitle': subtitle,
        'savedAt': savedAt.toIso8601String(),
      };

  factory Bookmark.fromMap(Map<String, String> map) => Bookmark(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        type: map['type'] ?? '',
        subtitle: map['subtitle'] ?? '',
        savedAt: DateTime.tryParse(map['savedAt'] ?? '') ?? DateTime.now(),
      );
}
