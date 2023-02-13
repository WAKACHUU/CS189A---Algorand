import 'package:algo_learn/theme/themes.dart';

class NFTCard extends StatelessWidget {
  final String source;
  final String title;
  final String imgSrc;
  final String description;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onTapped;

  NFTCard({
    required this.source,
    required this.title,
    required this.imgSrc,
    required this.description,
    required this.onTapped,
    this.textColor = Palette.textColor,
    this.backgroundColor = const Color(0xFFfff9f9),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTapped,
        child: Container(
          padding: EdgeInsets.all(paddingSizeNormal),
          width: 300,
          height: 160,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  width: 133,
                  height: 133,
                  child: Image.asset(imgSrc),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(source,
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ),
                    SizedBox(
                      width: 126,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline6
//                     ?.copyWith(color: textColor),
//               ),
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.subtitle1?.copyWith(),
//               ),