import 'package:flutter/material.dart';
import 'package:ui_practice/where_is_my_train/widgets/home_page_search_bar.dart';

class WhereHome extends StatelessWidget {
  const WhereHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Where is my Train',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4,
            tabs: [
              Text('SPOT'),
              Text('PNR'),
              Text('TICKETS'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HomePageSearchBar(text: 'From Station'),
                      Row(),
                      HomePageSearchBar(text: 'To Station'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
