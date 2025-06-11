import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../item/presentation/providers/item_provider.dart';
import '../../item/domain/models/item.dart';
import '../../../widgets/custom_bottom_nav_bar.dart';

class MyItems extends StatelessWidget {
  const MyItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFF3667B7),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 24,
                    top: 70,
                    child: Text(
                      'MY ITEMS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 30,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<ItemProvider>(
                builder: (context, itemProvider, child) {
                  if (itemProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (itemProvider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${itemProvider.error}'),
                          ElevatedButton(
                            onPressed: () => itemProvider.loadItems(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final myItems = itemProvider.myItems;
                  if (myItems.isEmpty) {
                    return const Center(
                      child: Text(
                        'No items found',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: myItems.length,
                    itemBuilder: (context, index) {
                      final item = myItems[index];
                      return _buildItemCard(context, item, itemProvider);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/report-item'),
        backgroundColor: const Color(0xFF3667B7),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildItemCard(BuildContext context, Item item, ItemProvider provider) {
    return GestureDetector(
      onTap: () => context.push('/my-item/${item.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status: ${item.status.toString().split('.').last}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Found on ${_getMonthName(item.foundDate.month)} ${item.foundDate.day}, ${item.foundDate.year}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context, item, provider),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Item item, ItemProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteItem(item.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}