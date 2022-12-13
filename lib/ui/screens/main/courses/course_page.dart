import 'package:algo_learn/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/ui/components/nft_card.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  // var width = MediaQuery.of(context).size.width;
  // var height = MediaQuery.of(context).size.height

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.accentColor,
          title: Text(
            'Course',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ))),
      body: Center(
        child: Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: NFTCard(
                  source: 'LECTURE 1',
                  title: 'Best Problem Solver',
                  imgSrc: 'assets/images/cat.jpeg',
                  description:
                      'Algorand is a decentralized, permissionless, pure proof-of-stake blockchain protocol that enables the creation of secure, scalable, and decentralized applications.',
                  onTapped: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
