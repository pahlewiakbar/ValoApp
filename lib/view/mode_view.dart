import 'package:flutter/material.dart';
import 'package:myproject/controller/home_controller.dart';

class ModeView extends StatefulWidget {
  const ModeView({super.key});

  @override
  State<ModeView> createState() => _ModeViewState();
}

class _ModeViewState extends State<ModeView>
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
        title: const Text('Mode'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: FutureBuilder(
        future: controller.allMode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                var mode = data[index];
                return FadeTransition(
                  opacity: CurvedAnimation(parent: animC, curve: Curves.easeIn),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: mode.displayIcon == null
                                  ? const Center(
                                      child: Icon(
                                      Icons.gamepad,
                                      color: Colors.white,
                                      size: 35,
                                    ))
                                  : Image.network('${mode.displayIcon}')),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${mode.displayName}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          mode.duration == null
                              ? const Text('-')
                              : Text('${mode.duration}')
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
