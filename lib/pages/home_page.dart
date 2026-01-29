import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/dummy_data.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/food_card.dart';
import '../widgets/footer.dart';
import '../widgets/background_pattern.dart';
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
        backgroundColor: AppColors.primary,
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
      body: BackgroundPattern(
        child: Column(
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
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeroSection(),
                          _buildCategoryList(),
                          _buildFoodSections(),
                          const SizedBox(height: 60),
                          const Footer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'DELIVER TO',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'New York, NY',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              children: [
                TextSpan(
                  text: 'Craving something\n',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                TextSpan(
                  text: 'delicious?',
                  style: TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search for food or restaurant...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(Icons.tune, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = ['All', ...DummyData.categories];
    // Map categories to basic icons for demo purposes
    final Map<String, IconData> icons = {
      'All': Icons.fastfood,
      'Pizza': Icons.local_pizza,
      'Burger': Icons.lunch_dining,
      'Drinks': Icons.local_drink,
      'Dessert': Icons.cake,
      'Biriyani': Icons.rice_bowl,
    };

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.4)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      icons[category] ?? Icons.fastfood,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodSections() {
    if (_selectedCategory != 'All') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('$_selectedCategory Menu'),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Wrap(
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
          ),
        ],
      );
    }

    // Show Featured Sections for "All"
    return Column(
      children: DummyData.categories.map((category) {
        final itemsInCategory = _filteredItems
            .where((item) => item.category == category)
            .toList();
        if (itemsInCategory.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Popular $category'),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
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
            ),
            const SizedBox(height: 40),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'See all',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
