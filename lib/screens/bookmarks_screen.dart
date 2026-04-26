import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import 'article_detail_screen.dart';
import '../data/constitution_data.dart';
import '../data/laws_data.dart';
import 'laws_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Bookmark> _bookmarks = [];
  bool _loading = true;

  ConstitutionArticle? _findArticleFromBookmark(Bookmark bookmark) {
    String articleNumber = '';

    if (bookmark.id.startsWith('art_')) {
      articleNumber = bookmark.id.substring(4);
    } else if (bookmark.id.startsWith('article_')) {
      articleNumber = bookmark.id.substring(8);
    } else if (bookmark.title.toLowerCase().startsWith('article ')) {
      articleNumber = bookmark.title.substring(8).trim();
    }

    if (articleNumber.isEmpty) return null;

    for (final part in constitutionParts) {
      for (final article in part.articles) {
        if (article.articleNumber == articleNumber) {
          return article;
        }
      }
    }
    return null;
  }

  LawSection? _findLawFromBookmark(Bookmark bookmark) {
    String sectionNumber = '';
    String actName = '';

    if (bookmark.id.startsWith('law_')) {
      final payload = bookmark.id.substring(4);
      final lastUnderscore = payload.lastIndexOf('_');
      if (lastUnderscore > 0 && lastUnderscore < payload.length - 1) {
        actName = payload.substring(0, lastUnderscore);
        sectionNumber = payload.substring(lastUnderscore + 1);
      }
    }

    if ((sectionNumber.isEmpty || actName.isEmpty) &&
        bookmark.title.startsWith('S.')) {
      final firstSpace = bookmark.title.indexOf(' ');
      if (firstSpace > 2) {
        sectionNumber = bookmark.title.substring(2, firstSpace);
        actName = bookmark.title.substring(firstSpace + 1).trim();
      }
    }

    if (sectionNumber.isEmpty || actName.isEmpty) return null;

    for (final category in indianLaws) {
      for (final section in category.sections) {
        if (section.sectionNumber == sectionNumber &&
            section.actName == actName) {
          return section;
        }
      }
    }
    return null;
  }

  void _openBookmark(Bookmark bookmark) {
    if (bookmark.type == 'article') {
      final article = _findArticleFromBookmark(bookmark);
      if (article != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(article: article),
          ),
        );
        return;
      }
    } else if (bookmark.type == 'law') {
      final section = _findLawFromBookmark(bookmark);
      if (section != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LawDetailScreen(section: section),
          ),
        );
        return;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open this bookmark. Please re-save it.'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await StorageService.getBookmarks();
    if (mounted) {
      setState(() {
        _bookmarks = bookmarks;
        _loading = false;
      });
    }
  }

  Future<void> _removeBookmark(String id) async {
    await StorageService.removeBookmark(id);
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bookmark_border,
                          size: 56,
                          color: theme.textTheme.bodySmall?.color),
                      const SizedBox(height: 12),
                      const Text('No bookmarks yet'),
                      const SizedBox(height: 4),
                      Text(
                        'Bookmark articles and law sections to find them quickly.',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _bookmarks.length,
                  itemBuilder: (context, index) {
                    final bm = _bookmarks[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          bm.type == 'article'
                              ? Icons.article
                              : Icons.gavel,
                          color: bm.type == 'article'
                              ? Colors.blue
                              : Colors.orange,
                        ),
                        title: Text(bm.title,
                            style: const TextStyle(fontSize: 14)),
                        subtitle: bm.subtitle.isNotEmpty
                            ? Text(bm.subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                            : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, size: 20),
                          onPressed: () => _removeBookmark(bm.id),
                        ),
                        onTap: () => _openBookmark(bm),
                      ),
                    );
                  },
                ),
    );
  }
}
