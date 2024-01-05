import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cocktail_mix_app/model/cocktail.dart';
import 'package:cocktail_mix_app/model/ingredient.dart';
import 'package:cocktail_mix_app/pages/cocktail_description_page.dart';
import 'package:cocktail_mix_app/pages/settings_page.dart';
import 'package:cocktail_mix_app/widgets/cocktail_widget.dart';
import 'package:cocktail_mix_app/widgets/ingredient_widget.dart';
import 'package:cocktail_mix_app/widgets/search_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ESelectedPage {
  mainPage,
  ingredientsPage,
  historyPage,
  settingsPage,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

ESelectedPage page = ESelectedPage.mainPage;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getFromSharedP();
  }

  void state() {
    setState(() {});
  }

  List<Cocktail> histories = [];
  List<Cocktail> cocktails = [
    Cocktail(
      name: 'Classic Mojito',
      compound:
          '1. 2 oz white rum\n2. 1 oz fresh lime juice\n3. 2 tsp sugar4.Fresh mint leaves\n5. Soda water\n6. Ice cubes ',
      description1:
          'Refreshing and minty, the Classic Mojito combines the zing of fresh lime with the coolness of mint, making it a perfect choice for a sunny day.',
      description2:
          'Muddle mint leaves and sugar. Add rum, lime juice, and ice. Top with soda water. Stir gently.',
      photo:
          'https://www.southernliving.com/thmb/CCkIxLWfRaSAvcKBslSCsFcrW4I=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Southern-Living-Mojito_009-65dc860743344068b5e5cab5efc85ebd.jpg',
    ),
    Cocktail(
      name: 'Margarita',
      compound:
          '1. 2 oz tequila\n2. 1 oz triple sec\n3. 1 oz fresh lime juice\n4. Salt for rimming\n5. Ice cubes',
      description1:
          'A tangy and zesty classic, the Margarita brings together the smoothness of tequila with the citrusy kick of triple sec and fresh lime juice. Rimmed with salt for that extra punch.',
      description2:
          'Rim glass with salt. Shake tequila, triple sec, and lime juice with ice. Strain into glass.',
      photo:
          'https://simplewine.ru/upload/iblock/91c/91c7a21bd468a4138c31278bb3cac06b.jpg',
    ),
    Cocktail(
      name: 'Pina Colada',
      compound:
          '1. 2 oz white rum\n2. 3 oz pineapple juice\n3. 1 oz coconut cream\n4. Pineapple slice for garnish\n5. Ice cubes',
      description1:
          'Transport yourself to a tropical paradise with the Pina Colada. Creamy coconut, sweet pineapple, and a hint of rum create a smooth and luscious concoction.',
      description2:
          'Blend rum, pineapple juice, coconut cream, and ice until smooth. Garnish with a pineapple slice.',
      photo:
          'https://www.southernliving.com/thmb/0QFVR_xDHH2swpQHfYsTHVKp-Qg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SouthernLivingpina-colada-7-3dccb56a0ad14dac96a60c33e5199430.jpg',
    ),
    Cocktail(
      name: 'Espresso Martini',
      compound:
          '1. 1 1/2 oz vodka\n2.1 oz coffee liqueur\n3. 1 oz freshly brewed espresso\n4. Coffee beans for garnish\n5. Ice cubes',
      description1:
          'For the coffee enthusiasts, the Espresso Martini is a rich and robust blend of vodka, coffee liqueur, and freshly brewed espresso—a perfect pick-me-up cocktail.',
      description2:
          'Shake vodka, coffee liqueur, and espresso with ice. Strain into a martini glass. Garnish with coffee beans.',
      photo:
          'https://dosmaderas.com/wp-content/uploads/2021/10/Dos-Maderas-rum-Cocktail-Espresso-Martini-HERO-6.jpg',
    ),
    Cocktail(
      name: 'Mai Tai',
      compound:
          '1. 1 1/2 oz light rum]\n2. 1/2 oz dark rum\n3. 1/2 oz triple sec\n4. 1 oz lime juice\n5. 1/2 oz orgeat syrup\n6. Orange slice and mint for garnish\n7. Ice cubes',
      description1:
          'Take a sip of the Mai Tai, a delightful balance of light and dark rum, triple sec, lime juice, and orgeat syrup. Topped with an orange slice and mint for that Polynesian touch.',
      description2:
          'Shake light rum, triple sec, lime juice, and orgeat syrup. Float dark rum on top. Garnish with orange slice and mint.',
      photo:
          'https://assets.epicurious.com/photos/652d6a561e73502e83ca459d/4:3/w_3653,h_2739,c_limit/mai-tai_RECIPE_100423_1967_VOG_final.jpg',
    ),
    Cocktail(
      name: 'Moscow Mule',
      compound:
          '1. 2 oz vodka\n2. 1 oz fresh lime juice\n3. 4 oz ginger beer\n4. Lime wedge for garnish\n5. Ice cubes',
      description1:
          'The Moscow Mule is a crisp and zingy cocktail featuring vodka, fresh lime juice, and ginger beer. Served in a copper mug, it\'s both stylish and refreshing.',
      description2:
          'Pour vodka and lime juice into a copper mug filled with ice. Top with ginger beer. Garnish with lime wedge.',
      photo:
          'https://www.seriouseats.com/thmb/FLPosYVmrC52PXPK7TB4LjsccOo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/20230920-SEA-MoscowMule-TwoBites-hero-35388989e6454f69895c82973e060387.jpg',
    ),
    Cocktail(
      name: 'Whiskey Sour',
      compound:
          '1. 2 oz bourbon\n2. 3/4 oz simple syrup\n3. 3/4 oz fresh lemon juice\n4.Lemon slice for garnish\n5. Ice cubes',
      description1:
          'A timeless classic, the Whiskey Sour combines the warmth of bourbon with the sweetness of simple syrup and the tartness of fresh lemon juice—simple yet sophisticated.',
      description2:
          'Shake bourbon, simple syrup, and lemon juice with ice. Strain into a glass. Garnish with a lemon slice.',
      photo:
          'https://assets.bonappetit.com/photos/63a4b2aba1a7b40ea0bebd03/16:9/w_3488,h_1962,c_limit/WhiskeySour.jpeg',
    ),
    Cocktail(
      name: 'Cosmopolitan',
      compound:
          '1. 1 1/2 oz vodka\n2. 1 oz triple sec\n3. 1/2 oz cranberry juice\n4. 1/2 oz fresh lime juice\n5. Orange twist for garnish\n6. Ice cubes',
      description1:
          'Elegance in a glass, the Cosmopolitan is a sophisticated mix of vodka, triple sec, cranberry juice, and a splash of fresh lime juice. Garnished with an orange twist for that cosmopolitan flair.',
      description2:
          'Shake vodka, triple sec, cranberry juice, and lime juice with ice. Strain into a martini glass. Garnish with an orange twist.',
      photo: 'https://worldrecipes.eu/storage/314803/cosmopolitan.jpg',
    ),
    Cocktail(
      name: 'Old Fashioned',
      compound:
          '1. 2 oz bourbon or rye whiskey\n2. 1 sugar cube\n3. 2-3 dashes Angostura bitters\n4. Orange twist and cherry for garnish\n5. Ice cubes',
      description1:
          'A cocktail with history, the Old Fashioned is a smooth blend of bourbon or rye whiskey, muddled sugar, and aromatic bitters. Garnished with an orange twist and a cherry.',
      description2:
          'Muddle sugar cube and bitters. Add whiskey and ice. Stir gently. Garnish with an orange twist and a cherry.',
      photo:
          'https://www.foodandwine.com/thmb/rUZMJEYJJgHZjRVg4eVSyiHYldA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/cocktails0615-xl-old-fashioned-882e4a3c1cac44f48768a123df839922.jpg',
    ),
    Cocktail(
        name: 'Strawberry Daiquiri',
        compound:
            '1. 2 oz white rum\n2. 1 oz fresh lime juice\n3. 1/2 oz simple syrup\n4. 4 strawberries, hulled\n5. Ice cubes',
        description1:
            'Embrace the sweetness of summer with the Strawberry Daiquiri. White rum, fresh lime juice, and sweet strawberries blended to perfection—pure indulgence in a glass.',
        description2:
            'Blend rum, lime juice, simple syrup, and strawberries with ice until smooth. Pour into a chilled glass',
        photo:
            'https://www.thespruceeats.com/thmb/w57u_v_z692IEz6kgZADoGwrSeo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/strawberry-daiquiri-recipes-759821_13_preview1-5b05f448ba61770036fbae90.jpeg')
  ];
  List<Ingredient> ingredients = [
    Ingredient(name: 'Vodka', type: EIngrType.spirits),
    Ingredient(name: 'Gin', type: EIngrType.spirits),
    Ingredient(name: 'Rum (Light)', type: EIngrType.spirits),
    Ingredient(name: 'Rum (Black)', type: EIngrType.spirits),
    Ingredient(name: 'Tequila', type: EIngrType.spirits),
    Ingredient(name: 'Bourbon', type: EIngrType.spirits),
    Ingredient(name: 'Whiskey (Rye)', type: EIngrType.spirits),
    Ingredient(name: 'Whiskey (Scotch)', type: EIngrType.spirits),
    Ingredient(name: 'Whiskey (rish)', type: EIngrType.spirits),
    Ingredient(name: 'Triple Sec', type: EIngrType.liqueurs),
    Ingredient(name: 'Grand Marnier', type: EIngrType.liqueurs),
    Ingredient(name: 'Amaretto', type: EIngrType.liqueurs),
    Ingredient(name: 'Baileys Irish Cream', type: EIngrType.liqueurs),
    Ingredient(name: 'Cointreau', type: EIngrType.liqueurs),
    Ingredient(name: 'Kahlúa', type: EIngrType.liqueurs),
    Ingredient(name: 'Fresh Lime Juice', type: EIngrType.mixers),
    Ingredient(name: 'Fresh Lemon Juice', type: EIngrType.mixers),
    Ingredient(name: 'Simple Syrup', type: EIngrType.mixers),
    Ingredient(name: 'Agave Nectar', type: EIngrType.mixers),
    Ingredient(name: 'Club Soda', type: EIngrType.mixers),
    Ingredient(name: 'Orange Juice', type: EIngrType.fruitJuices),
    Ingredient(name: 'Pineapple Juice', type: EIngrType.fruitJuices),
    Ingredient(name: 'Cranberry Juice', type: EIngrType.fruitJuices),
    Ingredient(name: 'Grapefruit Juice', type: EIngrType.fruitJuices),
    Ingredient(name: 'Apple Juice', type: EIngrType.fruitJuices),
    Ingredient(name: 'Angostura Bitters', type: EIngrType.bitters),
    Ingredient(name: 'Peychaud\'s Bitters', type: EIngrType.bitters),
    Ingredient(name: 'Orange Bitters', type: EIngrType.bitters),
    Ingredient(name: 'Cola', type: EIngrType.sodaandCola),
    Ingredient(name: 'Ginger Beer', type: EIngrType.sodaandCola),
    Ingredient(name: 'Sprite/7UP', type: EIngrType.sodaandCola),
    Ingredient(name: 'Tonic Water', type: EIngrType.sodaandCola),
    Ingredient(name: 'Mint Leaves', type: EIngrType.herbsandSpices),
    Ingredient(name: 'Basil Leaves', type: EIngrType.herbsandSpices),
    Ingredient(name: 'Cilantro', type: EIngrType.herbsandSpices),
    Ingredient(name: 'Cinnamon Sticks', type: EIngrType.herbsandSpices),
    Ingredient(name: 'Nutmeg', type: EIngrType.herbsandSpices),
    Ingredient(name: 'Simple Syrup', type: EIngrType.sweeteners),
    Ingredient(name: 'Agave Syrup', type: EIngrType.sweeteners),
    Ingredient(name: 'Grenadine', type: EIngrType.sweeteners),
    Ingredient(name: 'Honey', type: EIngrType.sweeteners),
    Ingredient(name: 'Maraschino Cherries', type: EIngrType.garnishes),
    Ingredient(name: 'Orange Twists', type: EIngrType.garnishes),
    Ingredient(name: 'Lemon Zest', type: EIngrType.garnishes),
    Ingredient(name: 'Cocktail Olives', type: EIngrType.garnishes),
  ];
  List<String> options = [
    'All',
    'Spirits',
    'Liqueurs',
    'Mixers',
    'Fruit Juices',
    'Bitters',
    'Soda and Cola',
    'Herbs and Spices',
    'Sweeteners',
    'Garnishes',
  ];
  List<Ingredient> selectedIngredients = [];
  int tagNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: getContent());
  }

  Widget getContent() {
    if (page == ESelectedPage.mainPage) {
      String searchText = '';
      return StatefulBuilder(builder: (context, setstate) {
        List<Cocktail> cocktailList = cocktails
            .where((element) =>
                element.name!.contains(searchText) ||
                element.name!.toLowerCase().contains(searchText))
            .toList();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 60, 30, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                'What kind of cocktail will you be making?',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SearchWidget(
                        callback: (value) {
                          searchText = value;
                          setstate(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: getCocktails(cocktailList: cocktailList),
                    )
                  ],
                ),
              ),
            ),
            BottomNavBar(
              callBack: () {
                setState(() {});
              },
            )
          ],
        );
      });
    } else if (page == ESelectedPage.historyPage) {
      return Column(
        children: [
          Expanded(
              child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 60, 30, 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text('History',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1,
                              fontSize: 32)),
                    ),
                  ],
                ),
              ),
              Expanded(child: SingleChildScrollView(child: getHistoryItems()))
            ],
          )),
          BottomNavBar(
            callBack: () {
              setState(() {});
            },
          )
        ],
      );
    } else if (page == ESelectedPage.ingredientsPage) {
      return Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 60, 30, 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text('Create your own cocktail',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1,
                                fontSize: 32)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: ChipsChoice<int>.single(
                    choiceStyle: C2ChipStyle.filled(
                        borderRadius: BorderRadius.circular(17),
                        foregroundStyle: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF979797),
                            fontSize: 14),
                        color: Colors.white,
                        backgroundOpacity: 0.15,
                        checkmarkColor: Colors.white,
                        hoveredStyle:
                            C2ChipStyle.filled(color: const Color(0xFF5418FF)),
                        selectedStyle: C2ChipStyle.filled(
                            color: const Color(0xFF5418FF),
                            foregroundStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                fontSize: 14))),
                    value: tagNumber,
                    onChanged: (val) => setState(() => tagNumber = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: getIngredients(),
                ),
              ],
            ),
          )),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectedIngredients = [];
                          setState(() {});
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: const Color(0xFFD13535),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child:
                                        Image.asset('assets/icons/reset.png'),
                                  ),
                                  const Text(
                                    'Reset',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          var cocktail = cocktails
                              .elementAt(Random().nextInt(cocktails.length));
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  CocktailDescriptionPage(
                                fromMixPage: true,
                                like: (cocktail) {
                                  cocktails.removeWhere((element) =>
                                      element.name == cocktail.name);
                                  cocktails.add(cocktail);
                                  addToSharedP(cocktails, histories);
                                },
                                cocktail: cocktail,
                                callBack: () {
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                          cocktail.date = DateTime.now();
                          histories.add(cocktail);
                          addToSharedP(cocktails, histories);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: const Color(0xFF5418FF),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mix cocktail',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              BottomNavBar(
                callBack: () {
                  setState(() {});
                },
              )
            ],
          )
        ],
      );
    } else if (page == ESelectedPage.settingsPage) {
      return Column(
        children: [
          const Expanded(child: SettingsPage()),
          BottomNavBar(
            callBack: () {
              setState(() {});
            },
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget getIngredients() {
    List<Widget> list = [];

    var items = groupBy(ingredients, (Ingredient e) {
      return e.type;
    });
    items.forEach((type, ingredients) {
      if (type == EIngrType.spirits && (tagNumber == 1 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Spirits',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.liqueurs && (tagNumber == 2 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Liqueurs',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.mixers && (tagNumber == 3 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Mixers',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.fruitJuices && (tagNumber == 4 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Fruit Juices',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.bitters && (tagNumber == 5 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Bitters',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.sodaandCola && (tagNumber == 6 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Soda and Cola',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.herbsandSpices &&
          (tagNumber == 7 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Herbs and Spices',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.sweeteners && (tagNumber == 8 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Sweeteners',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (type == EIngrType.garnishes && (tagNumber == 9 || tagNumber == 0)) {
        list.add(const Row(
          children: [
            Text('Garnishes',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8F8F8F),
                    fontSize: 13)),
          ],
        ));
      }
      if (tagNumber == 0) {
        for (var ingredient in ingredients) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 1) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.spirits)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 2) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.liqueurs)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 3) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.mixers)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 4) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.fruitJuices)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 5) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.bitters)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 6) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.sodaandCola)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 7) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.herbsandSpices)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 8) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.sweeteners)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 1) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.spirits)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      } else if (tagNumber == 9) {
        for (var ingredient in ingredients
            .where((element) => element.type == EIngrType.garnishes)) {
          bool selected = selectedIngredients.firstWhereOrNull(
                  (element) => element.name == ingredient.name) !=
              null;
          list.add(InkWell(
              onTap: () {
                if (selected) {
                  selected = false;
                  selectedIngredients.remove(ingredient);
                  setState(() {});
                } else {
                  selected = true;
                  selectedIngredients.add(ingredient);
                  setState(() {});
                }
              },
              child: IngredientWidget(
                  ingredient: ingredient, selected: selected)));
        }
      }
    });
    return Wrap(
      runSpacing: 20,
      spacing: 10,
      children: list,
    );
  }

  Widget getCocktails({required List<Cocktail> cocktailList}) {
    List<Widget> list = [];
    for (var cocktail in cocktailList) {
      cocktail.rating = randomDouble(3.8, 4.9);
      list.add(InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => CocktailDescriptionPage(
                cocktail: cocktail,
                like: (cocktail) {
                  cocktails
                      .removeWhere((element) => element.name == cocktail.name);
                  cocktails.add(cocktail);
                  addToSharedP(cocktails, histories);
                },
                callBack: () {
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 0, 19, 16),
          child: CocktailWidget(cocktail: cocktail),
        ),
      ));
    }
    return Column(
      children: list,
    );
  }

  double randomDouble(double min, double max) {
    return (Random().nextDouble() * (max - min) + min);
  }

  Widget getHistoryItems() {
    List<Widget> list = [];
    for (var history in histories) {
      list.add(Slidable(
        endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.2,
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                padding: const EdgeInsets.only(right: 8),
                onPressed: (context) {
                  histories.remove(history);
                  addToSharedP(cocktails, histories);
                  setState(() {});
                },
                icon: Icons.delete,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.red,
              ),
            ]),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => CocktailDescriptionPage(
                  cocktail: history,
                  like: (cocktail) {
                    cocktails.removeWhere(
                        (element) => element.name == cocktail.name);
                    cocktails.add(cocktail);
                    addToSharedP(cocktails, histories);
                  },
                  callBack: () {
                    setState(() {});
                  },
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(32)),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: CachedNetworkImageProvider(
                                history.photo!,
                              ),
                            ),
                          ),
                          height: 64,
                          width: 64,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              history.name!,
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Image.asset('assets/icons/time.png'),
                                ),
                                Text(
                                  DateFormat("hh:mm a")
                                      .format(history.date!)
                                      .toLowerCase(),
                                  style: const TextStyle(
                                      color: Color(0xFF979797),
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.chevron_right),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return Column(
      children: list,
    );
  }

  Future<void> addToSharedP(
      List<Cocktail>? cocktails, List<Cocktail>? history) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    if (cocktails != null) {
      prefs.setString('cocktails', jsonEncode(cocktails));
    }
    if (history != null) {
      prefs.setString('history', jsonEncode(history));
    }
  }

  void getFromSharedP() async {
    final prefs = await SharedPreferences.getInstance();

    final List<dynamic> jsonData1 =
        jsonDecode(prefs.getString('cocktails') ?? '[]');
    final List<dynamic> jsonData2 =
        jsonDecode(prefs.getString('history') ?? '[]');
    if (jsonData1
        .map<Cocktail>((jsonList) {
          {
            return Cocktail.fromJson(jsonList);
          }
        })
        .toList()
        .isNotEmpty) {
      cocktails = jsonData1.map<Cocktail>((jsonList) {
        {
          return Cocktail.fromJson(jsonList);
        }
      }).toList();
    }

    histories = jsonData2.map<Cocktail>((jsonList) {
      {
        return Cocktail.fromJson(jsonList);
      }
    }).toList();
    cocktails.sort((a, b) => a.name!.compareTo(b.name!));
    setState(() {});
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {super.key, required this.callBack, this.fromCocktailPage = false});
  final VoidCallback callBack;
  final bool fromCocktailPage;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(35, 16, 35, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              page = ESelectedPage.mainPage;

              if (widget.fromCocktailPage) {
                Navigator.pop(context);
              }
              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 50,
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == ESelectedPage.mainPage
                        ? Image.asset(
                            'assets/icons/recipes.png',
                            color: const Color(0xFF5418FF),
                          )
                        : Image.asset(
                            'assets/icons/recipes.png',
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Recipes',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == ESelectedPage.mainPage
                                  ? const Color(0xFF5418FF)
                                  : const Color(0xFF333333),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = ESelectedPage.ingredientsPage;
              if (widget.fromCocktailPage) {
                Navigator.pop(context);
              }
              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 70,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == ESelectedPage.ingredientsPage
                        ? Image.asset(
                            'assets/icons/mix.png',
                            color: const Color(0xFF5418FF),
                          )
                        : Image.asset(
                            'assets/icons/mix.png',
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Mix',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == ESelectedPage.ingredientsPage
                                  ? const Color(0xFF5418FF)
                                  : const Color(0xFF333333),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = ESelectedPage.historyPage;
              widget.callBack();
              if (widget.fromCocktailPage) {
                Navigator.pop(context);
              }
              setState(() {});
            },
            child: SizedBox(
                height: 70,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == ESelectedPage.historyPage
                        ? Image.asset(
                            'assets/icons/history.png',
                            color: const Color(0xFF5418FF),
                          )
                        : Image.asset(
                            'assets/icons/history.png',
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('History',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == ESelectedPage.historyPage
                                  ? const Color(0xFF5418FF)
                                  : const Color(0xFF333333),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = ESelectedPage.settingsPage;
              widget.callBack();

              setState(() {});
              if (widget.fromCocktailPage) {
                Navigator.pop(context);
              }
            },
            child: SizedBox(
                height: 50,
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == ESelectedPage.settingsPage
                        ? Image.asset(
                            'assets/icons/settings.png',
                            color: const Color(0xFF5418FF),
                          )
                        : Image.asset(
                            'assets/icons/settings.png',
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Settings',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == ESelectedPage.settingsPage
                                  ? const Color(0xFF5418FF)
                                  : const Color(0xFF333333),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}


class ShowBonusCocktailRecipe extends StatelessWidget {
  final String receipt;

  const ShowBonusCocktailRecipe({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 37, 254),
        body: SafeArea(
          bottom: false,
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(receipt),
            ),
          ),
        ),
      ),
    );
  }
}
