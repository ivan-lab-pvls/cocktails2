import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocktail_mix_app/model/cocktail.dart';
import 'package:cocktail_mix_app/pages/home_page.dart';
import 'package:cocktail_mix_app/widgets/cocktail_widget.dart';
import 'package:flutter/material.dart';

class CocktailDescriptionPage extends StatefulWidget {
  const CocktailDescriptionPage(
      {super.key,
      required this.cocktail,
      required this.callBack,
      required this.like,
      this.fromMixPage = false});
  final Cocktail cocktail;
  final Function callBack;
  final Function(Cocktail cocktail) like;
  final bool fromMixPage;

  @override
  State<CocktailDescriptionPage> createState() =>
      _CocktailDescriptionPageState();
}

class _CocktailDescriptionPageState extends State<CocktailDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 60, 30, 18),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/chevron_left.png'),
                  Flexible(
                    child: Text(
                        widget.fromMixPage ? 'Cocktails mix' : 'Recipes',
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                widget.cocktail.photo!,
                              ),
                            )),
                        height: 270,
                        width: double.infinity,
                      ),
                      Container(
                        height: 270,
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.white,
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                                stops: [0.4, 1.0])),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(widget.cocktail.name!,
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20)),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(32)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getStars(cocktail: widget.cocktail),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (widget.cocktail.isLiked == null) {
                                    widget.cocktail.isLiked = true;
                                  } else if (widget.cocktail.isLiked!) {
                                    widget.cocktail.isLiked = null;
                                  } else {
                                    widget.cocktail.isLiked = true;
                                  }
                                  widget.like(widget.cocktail);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: widget.cocktail.isLiked == null
                                      ? Image.asset('assets/icons/like.png')
                                      : widget.cocktail.isLiked!
                                          ? Image.asset(
                                              'assets/icons/like_colored.png',
                                            )
                                          : Image.asset(
                                              'assets/icons/like.png'),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  if (widget.cocktail.isLiked == null) {
                                    widget.cocktail.isLiked = false;
                                  } else if (widget.cocktail.isLiked!) {
                                    widget.cocktail.isLiked = false;
                                  } else {
                                    widget.cocktail.isLiked = null;
                                  }
                                  widget.like(widget.cocktail);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: widget.cocktail.isLiked == null
                                      ? Image.asset('assets/icons/dislike.png')
                                      : !widget.cocktail.isLiked!
                                          ? Image.asset(
                                              'assets/icons/dislike_colored.png')
                                          : Image.asset(
                                              'assets/icons/dislike.png'),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(32)),
                    child: Text(widget.cocktail.description1!,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF979797),
                            fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(32)),
                    child: Text(widget.cocktail.compound!,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF979797),
                            fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(32)),
                    child: Text(widget.cocktail.description2!,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF979797),
                            fontSize: 16)),
                  ),
                )
              ]),
            ),
          ),
          BottomNavBar(
            callBack: () {
              widget.callBack();
            },
            fromCocktailPage: true,
          )
        ],
      ),
    );
  }
}
