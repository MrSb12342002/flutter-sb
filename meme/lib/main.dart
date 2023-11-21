import 'package:flutter/material.dart';
import 'package:meme/memes.dart';
import 'package:meme/remort_service.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Meme(),
  ));
}

class Meme extends StatefulWidget {
  const Meme({super.key});

  @override
  State<Meme> createState() => _MemeState();
}

class _MemeState extends State<Meme> {
  GetMeme? currentMeme;
  String subReddit = '';
  var isLoaded = true;

  getData() async {
    currentMeme = await RemortService().getMemes(subReddit);
    print(currentMeme);
    if (currentMeme != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Text('MEME'),
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[850],
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text('Choose Meme page'),
            ),
            ListTile(
              title: const Text('DesiMemes'),
              onTap: () {
                setState(() {
                  subReddit = 'desimemes';
                });
                getData();
              },
            ),
            ListTile(
              title: const Text('IndianDankMeme'),
              onTap: () {
                setState(() {
                  subReddit = 'IndianDankMemes';
                });
                getData();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        child: Column(children: [
          SizedBox(
            height: 600.0,
            child: Image.network(
              currentMeme?.url ?? 'https://www.linkpicture.com/q/error_4.jpg',
              height: 600.0,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ElevatedButton(
                  onPressed: null,
                  child: Text(
                    'SHARE',
                    style: TextStyle(color: Colors.black),
                  )),
              const SizedBox(
                width: 100.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    getData();
                    setState(() {
                      isLoaded = true;
                    });
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
