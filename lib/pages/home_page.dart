import 'package:flutter/material.dart';
import 'dart:ui';
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
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          _buildSplitHeroSection(),
                          const SizedBox(height: 60),
                          _buildCategoryFilter(),
                          const SizedBox(height: 40),
                          _buildFoodSections(),
                          const SizedBox(height: 80),
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

  Widget _buildSplitHeroSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        Widget textContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'More than just food',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Taste the \nExtraordinary',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isDesktop ? 80 : 48,
                color: AppColors.textPrimary,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Experience culinary perfection delivered straight to your door. \nFresh ingredients, masters chefs, and unforgettable flavors.',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // Glass Search Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          onChanged: (value) =>
                              setState(() => _searchQuery = value),
                          decoration: const InputDecoration(
                            hintText: 'Search your cravings...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          elevation: 5,
                        ),
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );

        Widget imageContent = SizedBox(
          height: 500,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Decorative circle behind
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.5),
                ),
              ),
              // Rotating Image (Simulated with just an image for now)
              const _RotatingImage(),

              // Floating tags
              Positioned(
                top: 60,
                right: 20,
                child: _ScaleTag(icon: Icons.timer, text: "20 min"),
              ),
              Positioned(
                bottom: 80,
                left: 0,
                child: _ScaleTag(icon: Icons.star, text: "4.9 Rating"),
              ),
            ],
          ),
        );

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: textContent),
              const SizedBox(width: 40),
              Expanded(flex: 5, child: imageContent),
            ],
          );
        } else {
          return Column(
            children: [imageContent, const SizedBox(height: 40), textContent],
          );
        }
      },
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', ...DummyData.categories];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () => setState(() => _selectedCategory = category),
              borderRadius: BorderRadius.circular(30),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.withOpacity(0.2),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodSections() {
    List<FoodItem> itemsToShow = _filteredItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Delicacies',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See Menu',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Wrap/Grid
        Center(
          child: Wrap(
            spacing: 40,
            runSpacing: 60, // Extra spacing for the overlapping plates
            children: itemsToShow
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
}

class _RotatingImage extends StatefulWidget {
  const _RotatingImage({Key? key}) : super(key: key);

  @override
  State<_RotatingImage> createState() => __RotatingImageState();
}

class __RotatingImageState extends State<_RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 20000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: child,
        );
      },
      child: Container(
        width: 450,
        height: 450,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
            ), // Pizza
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 30,
              offset: Offset(0, 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScaleTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ScaleTag({Key? key, required this.icon, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
