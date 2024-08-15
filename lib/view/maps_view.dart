import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView>
    with SingleTickerProviderStateMixin {
  HomeController controller = HomeController();
  late AnimationController animC =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  void initState() {
    animC.forward();
    super.initState();
  }

  @override
  void dispose() {
    animC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Maps'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: FutureBuilder(
        future: controller.allMap(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                var maps = data[index];
                return FadeTransition(
                  opacity: CurvedAnimation(parent: animC, curve: Curves.easeIn),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: '${maps.splash}',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Text('Image not found'),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${maps.displayName}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text('failed to get data'),
          );
        },
      ),
    );
  }
}
