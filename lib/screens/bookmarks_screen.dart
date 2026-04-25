import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/storage_service.dart';
import 'article_detail_screen.dart';
import '../data/constitution_data.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Bookmark> _bookmarks = [];
  bool _loading = true;

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
                        onTap: () {
                          if (bm.type == 'article') {
                            // Find the article and navigate
                            for (final part in constitutionParts) {
                              for (final article in part.articles) {
                                if (bm.id == 'article_${article.articleNumber}') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ArticleDetailScreen(
                                          article: article),
                                    ),
                                  );
                                  return;
                                }
                              }
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
