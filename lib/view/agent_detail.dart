import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class AgentDetail extends StatelessWidget {
  final String uuid;
  const AgentDetail({super.key, required this.uuid});

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: FutureBuilder(
          future: controller.singleAgent(uuid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var detail = snapshot.data!;
              return ListView(
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Image.network('${detail.role?.displayIcon}'),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${detail.displayName}',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${detail.role?.displayName}',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: '${detail.fullPortrait}',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Text('Image not found'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description :',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '${detail.description}',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Special Ability :',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Column(
                          children: detail.abilities!
                              .map((ability) => GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            47, 221, 222, 255),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Image.network(
                                                  '${ability.displayIcon}'),
                                            ),
                                          ),
                                          title: Text(
                                            '${ability.displayName}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            '${ability.description}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('${ability.displayName}'),
                                          content: Text(
                                            '${ability.description}',
                                            textAlign: TextAlign.justify,
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Tutup'))
                                          ],
                                        ),
                                      );
                                    },
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  )
                ],
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
      ),
    );
  }
}
