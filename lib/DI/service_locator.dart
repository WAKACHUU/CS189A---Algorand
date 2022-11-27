import 'package:algorand_dart/algorand_dart.dart';

// import 'package:flutter_algorand_wallet/repositories/account_repository.dart';
// import 'package:flutter_algorand_wallet/theme/themes.dart';

// final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> register() async {}
}

final apiKey='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';

/// TODO Normally use Dependency Injection for this
final algodClient = AlgodClient(
    apiUrl: PureStake.TESTNET_ALGOD_API_URL,
    apiKey: apiKey,
    tokenKey: PureStake.API_TOKEN_HEADER,
);

final indexerClient = IndexerClient(
    apiUrl: PureStake.TESTNET_INDEXER_API_URL,
    apiKey: apiKey,
    tokenKey: PureStake.API_TOKEN_HEADER,
);

// final kmdClient = KmdClient(
//     apiUrl: '127.0.0.1',
//     apiKey: apiKey,
// );

// final algorand = Algorand(
//     algodClient: algodClient,
//     indexerClient: indexerClient,
//     kmdClient: kmdClient,
// );

// final accountRepository = AccountRepository(algorand);