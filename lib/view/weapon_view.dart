import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class WeaponView extends StatelessWidget {
  const WeaponView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
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
          if (snapshot.hasError) {
            return const Center(
              child: Text('failed to get data'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              var weapon = data[index];
              return Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        '${weapon.displayIcon}',
                        height: 50,
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
              );
            },
          );
        },
      ),
    );
  }
}
