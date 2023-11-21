import 'package:flutter/material.dart';
import 'package:music_player_app/models/catagory.dart';
import 'package:music_player_app/models/music.dart';
import 'package:music_player_app/sevices/catagory_oprations.dart';
import 'package:music_player_app/sevices/music_opratio.dart';

class HomePage extends StatelessWidget {
  Function _miniPlayer;
  HomePage(this._miniPlayer);

  Widget createCatagory(Catagory catagory) {
    return Container(
      color: Colors.blueGrey.shade300,
      child: Row(
        children: [
          Image.network(
            catagory.imageUrl,
            fit: BoxFit.cover,
            width: 70,
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              catagory.name,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> createListOfCatagories() {
    List<Catagory> catagoriList = CatogoryOprations().getCatagories();

    List<Widget> catagories = catagoriList
        .map((Catagory catagory) => createCatagory(catagory))
        .toList();

    return catagories;
  }

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget createGrid() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 300.0,
      child: GridView.count(
        childAspectRatio: 6 / 2,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: createListOfCatagories(),
      ),
    );
  }

  Widget createMusic(Music music) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            child: InkWell(
              onTap: () {
                _miniPlayer(music, stop: true);
              },
              child: Image.network(
                music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            music.name,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            music.desc,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget createMusicList(String label) {
    List<Music> MusicList = MusicOperations.getMusic();
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MusicList.length,
                itemBuilder: (context, index) {
                  return createMusic(MusicList[index]);
                }),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blueGrey.shade300,
          Colors.black,
          Colors.black,
          Colors.black,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(children: [
          createAppBar('Good Morning'),
          const SizedBox(
            height: 5,
          ),
          createGrid(),
          createMusicList('Made For You'),
          createMusicList('Hot This Month')
        ]),
      ),
    );
  }
}
