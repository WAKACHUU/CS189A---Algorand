import 'dart:math';

import 'package:feather_icons/feather_icons.dart';
import 'package:algo_learn/models/transaction_event.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:algo_learn/ui/components/spacing.dart';

typedef OnTransactionTap = void Function(TransactionEvent);

class TransactionTile extends StatelessWidget {
  final TransactionEvent transaction;
  final OnTransactionTap onTap;

  TransactionTile({required this.transaction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingSizeDefault),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              transaction.id,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Spacer(),
          Icon(iconData),
          HorizontalSpacing(of: paddingSizeNormal),
          Text((transaction.amount * pow(10, transaction.decimals * -1))
              .toStringAsFixed(transaction.decimals))
        ],
      ),
    );
  }

  IconData get iconData {
    switch (transaction.type) {
      case TransactionEventType.UNKNOWN:
        return FeatherIcons.xCircle;
      case TransactionEventType.SEND:
        return FeatherIcons.chevronsDown;
      case TransactionEventType.RECEIVE:
        return FeatherIcons.chevronsUp;
      case TransactionEventType.COMPOUND:
        return FeatherIcons.code;
    }
  }
}
