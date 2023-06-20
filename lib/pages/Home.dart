import 'package:flutter/material.dart';
import 'package:the_news/api/ApiService.dart';
import 'package:the_news/components/ArticleListTile.dart';

import '../model/Article.dart';
import '../utils/Constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Article>> articles;
  TextEditingController searchController = TextEditingController();
  bool clearSearch = false;
  int selectedItem = 0;

  String categoryDropDownValue = "general";
  String countryDropDownValue = "us";
  String languageDropDownValue = "en";

  @override
  void initState() {
    super.initState();
    articles = ApiService().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The News"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search news",
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        suffixIcon: clearSearch
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    clearSearch = false;
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      setState(() {
                        articles = ApiService().getSearchedArticles(
                            value.toLowerCase().trimRight());
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          clearSearch = true;
                        } else {
                          clearSearch = false;
                        }
                      });
                    },
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 400.0,
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Filter",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0))),
                                        value: categoryDropDownValue,
                                        items: Constants.categories
                                            .map(
                                              (String categoryKey,
                                                  String value) {
                                                return MapEntry(
                                                    categoryKey,
                                                    DropdownMenuItem(
                                                      value: categoryKey,
                                                      child: Text(value),
                                                    ));
                                              },
                                            )
                                            .values
                                            .toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            categoryDropDownValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0))),
                                        value: countryDropDownValue,
                                        items: Constants.countries
                                            .map(
                                              (countryKey,
                                                  String countryValue) {
                                                return MapEntry(
                                                    countryKey,
                                                    DropdownMenuItem(
                                                      value: countryKey,
                                                      child: Text(countryValue),
                                                    ));
                                              },
                                            )
                                            .values
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            countryDropDownValue = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0))),
                                        value: languageDropDownValue,
                                        items: Constants.languages
                                            .map(
                                              (languageKey, String value) {
                                                return MapEntry(
                                                    languageKey,
                                                    DropdownMenuItem(
                                                      value: languageKey,
                                                      child: Text(value),
                                                    ));
                                              },
                                            )
                                            .values
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            languageDropDownValue = value!;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            languageDropDownValue = "English";
                                            countryDropDownValue =
                                                "United States";
                                            categoryDropDownValue = "General";
                                          });
                                        },
                                        child: const Text("Reset"),
                                      ),
                                      const SizedBox(
                                        width: 40.0,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            debugPrint(
                                                "$categoryDropDownValue, $countryDropDownValue, $languageDropDownValue");
                                            setState(() {
                                              articles = ApiService()
                                                  .getFilteredArticles(
                                                      categoryDropDownValue,
                                                      countryDropDownValue /*,
                                                      languageDropDownValue*/
                                                      );
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text("Show Result"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.filter_list_rounded),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: FutureBuilder(
                future: articles,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasData) {
                    List<Article>? articles = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          articleListTile(context, articles![index]),
                      itemCount: articles?.length,
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(child: Container());
                }),
          ),
        ],
      ),
    );
  }
}
