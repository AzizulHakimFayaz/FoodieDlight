import '../models/food_item.dart';

class DummyData {
  static const List<String> categories = [
    'Pizza',
    'Burger',
    'Drinks',
    'Dessert',
    'Biriyani',
  ];

  static List<FoodItem> foodItems = [
    FoodItem(
      id: '1',
      name: 'Margherita Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
      price: 1250,
      description: 'Classic delight with 100% real mozzarella cheese.',
      category: 'Pizza',
    ),
    FoodItem(
      id: '2',
      name: 'Cheeseburger',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      price: 450,
      description: 'Juicy grilled beef patty with cheddar cheese.',
      category: 'Burger',
    ),
    FoodItem(
      id: '3',
      name: 'Chicken Biriyani',
      imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0',
      price: 350,
      description:
          'Aromatic basmati rice cooked with tender chicken and spices.',
      category: 'Biriyani',
    ),
    FoodItem(
      id: '4',
      name: 'Cola',
      imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97',
      price: 60,
      description: 'Refreshing carbonated soft drink.',
      category: 'Drinks',
    ),
    FoodItem(
      id: '5',
      name: 'Chocolate Lava Cake',
      imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c',
      price: 250,
      description: 'Rich chocolate cake with a molten center.',
      category: 'Dessert',
    ),
    FoodItem(
      id: '6',
      name: 'Pepperoni Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e',
      price: 1400,
      description: 'American classic with spicy pepperoni slices.',
      category: 'Pizza',
    ),
  ];
}
