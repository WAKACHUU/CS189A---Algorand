import 'package:algo_learn/models/models.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:algo_learn/ui/components/spacing.dart';
import 'package:algo_learn/utils/crypto_utils.dart';

typedef OnCryptoCardTap = void Function(AlgorandStandardAsset asset);

class CryptoCard extends StatelessWidget {
  final AlgorandStandardAsset asset;
  final bool selected;
  final Image? image;
  final selectedColor = Palette.accentColor;
  final unselectedColor = Color(0xFFfff9f9);
  final OnCryptoCardTap onTapped;
  final OnCryptoCardTap? onLongPress;

  CryptoCard({
    required this.asset,
    required this.onTapped,
    this.selected = false,
    this.image,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? selectedColor : unselectedColor;
    final textColor = selected ? Colors.white : Colors.black;
    final currencyColor = selected ? Colors.white : Color(0xFFD7C4C8);
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () => onTapped(asset),
        onLongPress: () {
          final onLongPress = this.onLongPress;
          if (onLongPress == null) return;

          onLongPress(asset);
        },
        child: Container(
          width: 160,
          padding: EdgeInsets.all(paddingSizeMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: image,
              ),
              VerticalSpacing(of: 20),
              Text(
                '${CryptoUtils.format(asset.amount, asset.decimals)} ${asset.unitName}',
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Spacer(),
              Text(
                asset.name ?? '',
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: currencyColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
