import 'package:flutter/material.dart';
import 'package:spacebook/list_your_space_page.dart';
import 'package:spacebook/services/api_service.dart';

const Color _green = Color(0xFF3F6B00);

class MySpacesPage extends StatefulWidget {
  const MySpacesPage({super.key});

  @override
  State<MySpacesPage> createState() => _MySpacesPageState();
}

class _MySpacesPageState extends State<MySpacesPage> {
  List<dynamic> _spaces = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMySpaces();
  }

  Future<void> _loadMySpaces() async {
    try {
      final data = await ApiService.getMySpaces();
      setState(() {
        _spaces = data;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Spaces',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _green))
          : _spaces.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.store_outlined, size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      const Text('No spaces listed yet',
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      const SizedBox(height: 8),
                      const Text('Tap + Add Space to list your first space',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadMySpaces,
                  color: _green,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      children: _spaces
                          .map((space) => _MySpacesCard(
                                space: space,
                                onRefresh: _loadMySpaces,
                              ))
                          .toList(),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _green,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListYourSpacePage()),
          );
          _loadMySpaces(); // refresh after returning
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Space", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _MySpacesCard extends StatelessWidget {
  final dynamic space;
  final VoidCallback onRefresh;

  const _MySpacesCard({required this.space, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final imageUrl = space['image_url'] ?? '';
    final title = space['title'] ?? 'Untitled';
    final price = space['price_per_hr'] ?? 0;
    final status = space['is_active'] == true ? 'ACTIVE' : 'INACTIVE';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _imagePlaceholder(),
                      )
                    : _imagePlaceholder(),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹$price/hr',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _green,
                      ),
                    ),
                    _ActionButtons(
                      spaceId: space['id'],
                      title: title,
                      currentPrice: price,
                      onRefresh: onRefresh,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 170,
      color: Colors.grey[200],
      child: const Icon(Icons.image, size: 50, color: Colors.grey),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final int spaceId;
  final String title;
  final int currentPrice;
  final VoidCallback onRefresh;

  const _ActionButtons({
    required this.spaceId,
    required this.title,
    required this.currentPrice,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showDeleteDialog(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.delete_forever_outlined,
                color: Colors.red, size: 20),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => _showChangePriceDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: _green,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          ),
          child: const Text('Change Price',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Delete Space?",
            style: TextStyle(fontWeight: FontWeight.w600)),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",
                style: TextStyle(color: _green, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              Navigator.pop(context);
              try {
                final res = await http_delete(spaceId);
                if (res['message'] != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Space deleted')));
                  onRefresh();
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to delete')));
              }
            },
            child: const Text("Delete",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> http_delete(int id) async {
    final res = await ApiService.deleteSpace(id);
    return res;
  }

  void _showChangePriceDialog(BuildContext context) {
    final controller =
        TextEditingController(text: currentPrice.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Change Price",
            style: TextStyle(fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '₹ ',
                labelText: 'New Price per hour',
                labelStyle: const TextStyle(color: _green),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: _green, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",
                style: TextStyle(color: _green, fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              final newPrice = int.tryParse(controller.text);
              if (newPrice == null || newPrice <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter a valid price')));
                return;
              }
              Navigator.pop(context);
              try {
                await ApiService.updateSpacePrice(spaceId, newPrice);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Price updated!')));
                onRefresh();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update price')));
              }
            },
            child: const Text("Update",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}