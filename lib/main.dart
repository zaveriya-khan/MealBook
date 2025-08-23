import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class Recipe {
  final String title;
  final String image;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.image,
    required this.ingredients,
    required this.instructions,
  });
}

final recipes = [
  Recipe(
    title: "Spaghetti Carbonara",
    image: "assets/images/spaghetti_carbonara.png",
    ingredients: [
      "Spaghetti",
      "Eggs",
      "Parmesan cheese",
      "Pancetta",
      "Black pepper",
    ],
    instructions:
        "1. Cook pasta\n2. Fry pancetta\n3. Mix eggs & cheese\n4. Combine all with pepper.",
  ),
  Recipe(
    title: "Avocado Toast",
    image: "assets/images/avocado_toast.png",
    ingredients: [
      "Bread slices",
      "Avocado",
      "Lemon juice",
      "Salt & pepper",
      "Chili flakes",
    ],
    instructions:
        "1. Toast bread\n2. Mash avocado with lemon\n3. Spread on bread\n4. Sprinkle seasoning.",
  ),
  Recipe(
    title: "Classic Pancakes",
    image: "assets/images/classic_pancakes.png",
    ingredients: [
      "Flour",
      "Milk",
      "Eggs",
      "Baking powder",
      "Maple syrup",
    ],
    instructions:
        "1. Mix flour, eggs, milk\n2. Heat pan & pour batter\n3. Flip when bubbly\n4. Serve with syrup.",
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'recipe/:id',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return RecipeDetailPage(recipe: recipes[id]);
              },
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 100, 239, 172)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🍳 Flavour Fusion"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Hungry? Let’s Cook Something Amazing! 👩‍🍳",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    context.go('/recipe/$index');
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                          child: Image.asset(
                            recipe.image,
                            width: 120,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              recipe.title,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(recipe.image),
            ),
            const SizedBox(height: 16),
            Text(
              "Ingredients 🥬",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            ...recipe.ingredients.map(
              (ing) => ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(ing),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Instructions 👨‍🍳",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              recipe.instructions,
              style: const TextStyle(fontSize: 17, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
