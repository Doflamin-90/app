import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/artwork.dart';
import '../models/layer_note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('art_revision_tutorial.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE artworks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE layer_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        artworkId INTEGER NOT NULL,
        layerType TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        noteText TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (artworkId) REFERENCES artworks (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE tutorial_progress (
        step INTEGER PRIMARY KEY,
        completed INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertArtwork(Artwork artwork) async {
    final db = await instance.database;
    return await db.insert('artworks', artwork.toMap());
  }

  Future<List<Artwork>> getArtworks() async {
    final db = await instance.database;
    final result = await db.query('artworks', orderBy: 'id DESC');
    return result.map((json) => Artwork.fromMap(json)).toList();
  }

  Future<int> insertLayerNote(LayerNote note) async {
    final db = await instance.database;
    return await db.insert('layer_notes', note.toMap());
  }

  Future<List<LayerNote>> getLayerNotes(int artworkId) async {
    final db = await instance.database;
    final result = await db.query(
      'layer_notes',
      where: 'artworkId = ?',
      whereArgs: [artworkId],
    );
    return result.map((json) => LayerNote.fromMap(json)).toList();
  }

  Future<void> completeTutorialStep(int step) async {
    final db = await instance.database;
    await db.insert(
      'tutorial_progress',
      {'step': step, 'completed': 1},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<int>> getCompletedTutorialSteps() async {
    final db = await instance.database;
    final result = await db.query(
      'tutorial_progress',
      where: 'completed = 1',
    );
    return result.map((row) => row['step'] as int).toList();
  }
}