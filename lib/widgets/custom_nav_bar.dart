import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final int cartCount;
  final VoidCallback onCartTap;

  const CustomNavBar({
    Key? key,
    required this.cartCount,
    required this.onCartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 2000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Row(
                  children: [
                    Icon(Icons.restaurant, color: AppColors.primary, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      'FoodieDelight',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),

                // Menu Items (Web Style)

                // Cart
                Container(
                  child: Row(
                    children: [
                      if (MediaQuery.of(context).size.width > 768)
                        Row(
                          children: [
                            _NavBarItem(title: 'Home', isActive: true),
                            _NavBarItem(title: 'Menu'),
                            _NavBarItem(title: 'Offers'),
                            _NavBarItem(title: 'Contact'),
                          ],
                        ),
                      InkWell(
                        onTap: onCartTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                size: 24,
                                color: AppColors.textPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cartCount > 0 ? '$cartCount' : 'Cart',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final bool isActive;

  const _NavBarItem({Key? key, required this.title, this.isActive = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          color: isActive ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
