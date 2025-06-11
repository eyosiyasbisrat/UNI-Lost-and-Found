import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/item_provider.dart';
import '../domain/models/item.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class ItemsLost extends ConsumerWidget {
  const ItemsLost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(itemProvider);
    final itemNotifier = ref.read(itemProvider.notifier);

    if (!itemState.isLoading && itemState.items.isEmpty && itemState.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        itemNotifier.loadItems();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        'ITEMS LOST',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 24,
                      top: 70,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (itemState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (itemState.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${itemState.error}'),
                          ElevatedButton(
                            onPressed: () => itemNotifier.loadItems(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(24, 24, 16, 16),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: itemNotifier.todayLostItems.length,
                          itemBuilder: (context, index) {
                            return _buildTodayItem(
                              context,
                              itemNotifier.todayLostItems[index],
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(24, 24, 16, 16),
                        child: Text(
                          'Last 7 Days',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemNotifier.lastSevenDaysLostItems.length,
                        itemBuilder: (context, index) {
                          return _buildLastSevenDaysItem(
                            context,
                            itemNotifier.lastSevenDaysLostItems[index],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildTodayItem(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () => context.push('/item-details/${item.id}'),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 24.0),
        decoration: BoxDecoration(
          color: const Color(0xFFC4E0F4),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                item.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                  Text(
                    item.location,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${_getMonthName(item.foundDate.month)} ${item.foundDate.day}, ${item.foundDate.year}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastSevenDaysItem(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () => context.push('/item-details/${item.id}'),
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
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    item.location,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${_getMonthName(item.foundDate.month)} ${item.foundDate.day}, ${item.foundDate.year}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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