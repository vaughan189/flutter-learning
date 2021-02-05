import 'package:flutter_config/flutter_config.dart';

final auth0Domain = FlutterConfig.get('AUTH0_DOMAIN');
final auth0ClientId = FlutterConfig.get('AUTH0_CLIENT_ID');

final auth0redirectUri = FlutterConfig.get('AUTH0_REDIRECT_URI');
final auth0Issuer= 'https://$auth0Domain';
