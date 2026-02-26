import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final Color green = const Color(0xFF4A7C15);

  int selectedDateIndex = 0;
  String selectedSlot = "12:00 PM";
  String selectedSeat = "A1";

  final List<Map<String, String>> dates = [
    {"day": "THU", "date": "24"},
    {"day": "FRI", "date": "25"},
    {"day": "SAT", "date": "26"},
    {"day": "SUN", "date": "27"},
    {"day": "MON", "date": "28"},
  ];

  final List<String> slots = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
  ];

  final List<String> seats = [
    "A1", "A2", "B1", "B2",
    "C1", "C2", "D1", "D2"
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
                const SizedBox(height: 110),
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
              image: AssetImage("assets/library.jpg"),
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
            "City Central Library",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Main Square, Education District",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              const Text("4.8 (2.5k+ reviews)"),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Starting from",
                      style: TextStyle(color: Colors.grey)),
                  Text("₹80/hr",
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
            "Quiet study spaces equipped with high-speed Wi-Fi, ergonomic seating and individual power outlets.",
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
          const Text("Available Seat",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          seatGrid(),
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
            width: 95,
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
                  color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget seatGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: seats.map((seat) {
        bool isSelected = selectedSeat == seat;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedSeat = seat;
            });
          },
          child: Container(
            width: 70,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected ? green : Colors.white,
              border: Border.all(color: green),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chair,
                    color: isSelected ? Colors.white : green),
                const SizedBox(height: 4),
                Text(
                  "Seat $seat",
                  style: TextStyle(
                      fontSize: 10,
                      color:
                          isSelected ? Colors.white : Colors.black),
                )
              ],
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
        facilityItem(Icons.wifi, "Wi-Fi"),
        facilityItem(Icons.power, "Outlets"),
        facilityItem(Icons.local_cafe, "Cafeteria"),
        facilityItem(Icons.print, "Printing"),
        facilityItem(Icons.ac_unit, "AC"),
      ],
    );
  }

  Widget facilityItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey[100],
          child: Icon(icon, color: green),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
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
                Text("1 Seat Selected",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text("₹80",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A7C15),
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
    return const CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(Icons.arrow_back, color: Colors.black),
    );
  }
}