import 'package:flutter_dotenv/flutter_dotenv.dart';

const String kMaterialAppTitle = 'Flutter Clean Architecture';

// API
const String kBaseUrl = 'https://newsapi.org/v2';

const String kApiKey = dotenv.get('API_KEY', fallback: '');

// Database
const String kArticlesTableName = 'articles_table';

const String kDatabaseName = 'app_database.db';
