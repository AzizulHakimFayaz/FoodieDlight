import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/dummy_data.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/food_card.dart';
import '../widgets/footer.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import 'order_details_page.dart';
import '../widgets/background_pattern.dart';

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
      backgroundColor: AppColors.background,
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
                          _buildCategoryFilter(), // Pill shaped
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900], // Fallback color
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
          ), // Dark food background
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ), // Darken image for text readability
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Craving something?',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
                fontFamily:
                    'Poppins', // Assuming font family is available or defaults
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Let\'s get you fed with the best in town.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            Container(
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                      decoration: const InputDecoration(
                        hintText: 'Search for dishes, restaurants...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Search'),
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

  Widget _buildCategoryFilter() {
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

    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 40),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => setState(() => _selectedCategory = category),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      icons[category] ?? Icons.fastfood,
                      size: 18,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodSections() {
    // Similar to before but using Wrap for grid layout to display cards more nicely
    List<FoodItem> itemsToShow = _filteredItems;

    // Header
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Items',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Grid
        LayoutBuilder(
          builder: (context, constraints) {
            // Simple responsive grid logic
            double cardWidth = 350;
            int crossAxisCount = (constraints.maxWidth / cardWidth).floor();
            if (crossAxisCount < 1) crossAxisCount = 1;

            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: itemsToShow
                  .map(
                    (item) => FoodCard(
                      foodItem: item,
                      onAdd: () => _addToCart(item),
                      onBuy: () => _buyNow(item),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
