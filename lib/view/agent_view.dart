import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';
import 'agent_detail.dart';

class AgentView extends StatefulWidget {
  const AgentView({super.key});

  @override
  State<AgentView> createState() => _AgentViewState();
}

class _AgentViewState extends State<AgentView>
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
        title: const Text('Agent'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: FutureBuilder(
        future: controller.allAgent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                var agent = data[index];
                var background =
                    int.parse(agent.backgroundGradientColors![0], radix: 16);
                return FadeTransition(
                  opacity: CurvedAnimation(parent: animC, curve: Curves.easeIn),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgentDetail(uuid: agent.uuid),
                        )),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(background),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                        ),
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: '${agent.fullPortrait}',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Text('Image not found'),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${agent.displayName}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '${agent.role?.displayName}',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
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
