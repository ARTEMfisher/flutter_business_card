import 'package:business_card/const.dart';
import 'package:flutter/material.dart';
import 'package:business_card/settings.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              child: const Icon(Icons.arrow_back)),
          const Text('About')
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(15.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Application developer: ',
              style: aboutText,
            ),
            const Text(
              'Artem Biryukov',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              'Many thanks for the photo to the site https://free-images.com',
              style: aboutText,
            )
          ],
        ),
      ),
    );
  }
}
