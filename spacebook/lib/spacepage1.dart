import 'package:flutter/material.dart';

class ArenaScreen extends StatefulWidget {
  const ArenaScreen({super.key});

  @override
  State<ArenaScreen> createState() => _ArenaScreenState();
}

class _ArenaScreenState extends State<ArenaScreen> {
  final Color green = const Color(0xFF4A7C15);

  int selectedDateIndex = 0;
  String selectedSlot = "10:00 AM";

  final List<Map<String, String>> dates = [
    {"day": "THU", "date": "24"},
    {"day": "FRI", "date": "25"},
    {"day": "SAT", "date": "26"},
    {"day": "SUN", "date": "27"},
    {"day": "MON", "date": "28"},
  ];

  final List<String> slots = [
    "06:00 AM",
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerSection(),
                contentSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
          bottomBar(),
        ],
      ),
    );
  }

  Widget headerSection() {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/arena.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          color: Colors.black.withOpacity(0.3),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: circleIcon(Icons.arrow_back),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: Row(
            children: [
              circleIcon(Icons.favorite_border),
              const SizedBox(width: 10),
              circleIcon(Icons.share),
            ],
          ),
        ),
      ],
    );
  }

  Widget contentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Olympic Green Arena",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Downtown Sports Complex, Sector 4",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              const Text("4.9 (150+ reviews)"),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Starting from",
                      style: TextStyle(color: Colors.grey)),
                  Text("₹1,200/hr",
                      style: TextStyle(
                          color: green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text("About",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            "FIFA-certified turf suitable for 7-a-side matches with professional floodlights, premium locker rooms, and spectator seating.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          dateSelector(),
          const SizedBox(height: 20),
          const Text("Available Slots",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          slotsGrid(),
          const SizedBox(height: 20),
          const Text("Facilities",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          facilitiesRow(),
        ],
      ),
    );
  }

  Widget dateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Select Date",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text("October", style: TextStyle(color: green)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dates.length, (index) {
            bool isSelected = selectedDateIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDateIndex = index;
                });
              },
              child: Container(
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? green : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(dates[index]["day"]!,
                        style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey)),
                    const SizedBox(height: 4),
                    Text(dates[index]["date"]!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : Colors.black)),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget slotsGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        bool isSelected = selectedSlot == slot;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedSlot = slot;
            });
          },
          child: Container(
            width: 90,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? green : Colors.white,
              border: Border.all(color: green),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              slot,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget facilitiesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        facilityItem(Icons.shower, "Showers"),
        facilityItem(Icons.lightbulb, "Lights"),
        facilityItem(Icons.local_parking, "Parking"),
        facilityItem(Icons.medical_services, "First Aid"),
      ],
    );
  }

  Widget facilityItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[100],
          child: Icon(icon, color: green),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget bottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1 Slot Selected",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text("₹1,200",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text("Contact Owner"),
            )
          ],
        ),
      ),
    );
  }

  Widget circleIcon(IconData icon) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black),
    );
  }
}