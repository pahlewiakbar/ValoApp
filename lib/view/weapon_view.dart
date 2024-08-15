import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myproject/controller/home_controller.dart';

class WeaponView extends StatefulWidget {
  const WeaponView({super.key});

  @override
  State<WeaponView> createState() => _WeaponViewState();
}

class _WeaponViewState extends State<WeaponView>
    with SingleTickerProviderStateMixin {
  final HomeController controller = HomeController();
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
        title: const Text('Arsenal'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: FutureBuilder(
        future: controller.allWeapon(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                var weapon = data[index];
                return FadeTransition(
                  opacity: CurvedAnimation(parent: animC, curve: Curves.easeIn),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            height: 50,
                            imageUrl: '${weapon.displayIcon}',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Text('Image not found'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${weapon.displayName}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          weapon.shopData == null
                              ? const Text('')
                              : Text(
                                  '${weapon.shopData?.category}',
                                  style: const TextStyle(fontSize: 15),
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
