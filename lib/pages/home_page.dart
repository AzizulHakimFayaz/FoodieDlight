import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/dummy_data.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/food_card.dart';
import '../widgets/footer.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import 'order_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<CartItem> _cart = [];

  void _addToCart(FoodItem item) {
    setState(() {
      final existingIndex = _cart.indexWhere((c) => c.foodItem.id == item.id);
      if (existingIndex != -1) {
        _cart[existingIndex].quantity++;
      } else {
        _cart.add(CartItem(foodItem: item));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _buyNow(FoodItem item) {
    final existingIndex = _cart.indexWhere((c) => c.foodItem.id == item.id);
    if (existingIndex == -1) {
      setState(() {
        _cart.add(CartItem(foodItem: item));
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsPage(initialCart: _cart),
      ),
    );
  }

  List<FoodItem> get _filteredItems {
    return DummyData.foodItems.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch =
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          CustomNavBar(
            cartCount: _cart.length,
            onCartTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsPage(initialCart: _cart),
                ),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(),
                  _buildCategoryFilter(),
                  _buildFoodList(),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(color: AppColors.surface),
      child: Column(
        children: [
          const Text(
            'Delicious Food Delivered To You',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search for food or restaurant...',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', ...DummyData.categories];
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodList() {
    // Group items by category to display them in sections as requested
    // If "All" is selected, we show multiple lists.
    // If specific category, we show one list.

    if (_selectedCategory != 'All') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedCategory,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              children: _filteredItems
                  .map(
                    (item) => FoodCard(
                      foodItem: item,
                      onAdd: () => _addToCart(item),
                      onBuy: () => _buyNow(item),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    }

    // For "All", we want to show sections like "Pizza", "Burger" etc.
    // But we only show sections that have items matching the search query.

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: DummyData.categories.map((category) {
          final itemsInCategory = _filteredItems
              .where((item) => item.category == category)
              .toList();

          if (itemsInCategory.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                children: itemsInCategory
                    .map(
                      (item) => FoodCard(
                        foodItem: item,
                        onAdd: () => _addToCart(item),
                        onBuy: () => _buyNow(item),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 40),
            ],
          );
        }).toList(),
      ),
    );
  }
}
