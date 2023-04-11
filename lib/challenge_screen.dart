import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        foregroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/639005?v=4'),
                        radius: 24,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        iconSize: 32,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "MONDAY 16",
                      style: TextStyle(
                        color: const Color(
                          0xffe2e2e2,
                        ).withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color(0xffe2e2e2),
                        fontWeight: FontWeight.w500,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("TODAY"),
                          const SizedBox(width: 4),
                          const Text(
                            "•",
                            style: TextStyle(
                              color: Color(0xffa4337d),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "17",
                            style: TextStyle(
                              color: const Color(0xffeaeaea).withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "18",
                            style: TextStyle(
                              color: const Color(0xffeaeaea).withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "19",
                            style: TextStyle(
                              color: const Color(0xffeaeaea).withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "20",
                            style: TextStyle(
                              color: const Color(0xffeaeaea).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const CalendarCard(
                  startHour: 11,
                  startMinute: 30,
                  endHour: 12,
                  endMinute: 20,
                  title: "Design",
                  category: "Meeting",
                  cardColor: Color(0xfffdf771),
                  participants: [
                    "Alex",
                    "Helena",
                    "Nana",
                  ],
                ),
                const SizedBox(height: 10),
                const CalendarCard(
                  startHour: 12,
                  startMinute: 35,
                  endHour: 14,
                  endMinute: 10,
                  title: "Daily",
                  category: "Project",
                  cardColor: Color(0xff956dc8),
                  participants: [
                    "Richard",
                    "Ciry",
                    "Alex",
                    "Helena",
                    "Nana",
                    "Den"
                  ],
                  attending: true,
                ),
                const SizedBox(height: 10),
                const CalendarCard(
                  startHour: 15,
                  startMinute: 00,
                  endHour: 16,
                  endMinute: 30,
                  title: "Weekly",
                  category: "Planning",
                  cardColor: Color(0xffc6ed67),
                  participants: [
                    "Den",
                    "Nana",
                    "Mark",
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarCard extends StatelessWidget {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final String title;
  final String category;
  final List<String> participants;
  final bool attending;
  final Color cardColor;
  const CalendarCard({
    super.key,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.title,
    required this.category,
    required this.cardColor,
    required this.participants,
    this.attending = false,
  });

  @override
  Widget build(BuildContext context) {
    final totalParticipants = participants.length + (attending ? 1 : 0);
    final hasMore = totalParticipants > 3 ? true : false;
    final participantsToShow = hasMore
        ? participants.sublist(0, 2)
        : participants.sublist(0, totalParticipants);
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: cardColor,
      ),
      child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 15, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        Text(
                          startHour.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          startMinute.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          endHour.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          endMinute.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -4,
                          height: 1,
                        ),
                      ),
                      Text(
                        category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -4,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 55,
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w500,
                  ),
                  child: Row(
                    children: [
                      if (attending) ...[
                        const Text(
                          "ME",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const Spacer()
                      ],
                      for (final participant in participantsToShow) ...[
                        Text(
                          participant.toUpperCase(),
                        ),
                        const Spacer()
                      ],
                      if (hasMore) ...[
                        Text(
                          "+${totalParticipants - 3}",
                        ),
                        const Spacer()
                      ]
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
