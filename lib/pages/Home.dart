import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_news/components/ArticleListTile.dart';
import 'package:the_news/provider/NewsProvider.dart';
import 'package:the_news/utils/Constants.dart';

import '../model/Article.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  bool clearSearch = false;
  int selectedItem = 0;
  String categoryDropDownValue = "general";
  String countryDropDownValue = "us";
  String languageDropDownValue = "en";
  ExpansionTileController countryController = ExpansionTileController();
  ExpansionTileController languageController = ExpansionTileController();
  ExpansionTileController categoryController = ExpansionTileController();

  @override
  void initState() {
    super.initState();
    final providerInstance = Provider.of<NewsProvider>(context, listen: false);
    providerInstance.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    var newsProvider = context.read<NewsProvider>();

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
                                  newsProvider.resetRequest();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      /*setState(() {
                         articles = ApiService().getSearchedArticles(
                            value.toLowerCase().trimRight());
                      });*/
                      newsProvider
                          .getSearchedArticles(value.toLowerCase().trimRight());
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
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
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
                                      child: ExpansionTile(
                                        controller: countryController,
                                        title: const Text(
                                          "Country",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        onExpansionChanged: (isExpanded) {
                                          setState(() {
                                            //ToDo()
                                          });
                                        },
                                        children: Constants.countries
                                            .map((key, value) {
                                              return MapEntry(
                                                  key,
                                                  RadioListTile(
                                                      title: Text(value),
                                                      value: value,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .trailing,
                                                      groupValue:
                                                          countryDropDownValue,
                                                      onChanged:
                                                          (selectedCountry) {
                                                        setState(() {
                                                          countryDropDownValue =
                                                              selectedCountry!;
                                                          countryController
                                                              .collapse();
                                                        });
                                                      }));
                                            })
                                            .values
                                            .toList(),
                                      )
                                      /*DropdownButtonFormField<String>(
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
                                      )*/
                                      ,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ExpansionTile(
                                        controller: categoryController,
                                        title: const Text(
                                          "Category",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        onExpansionChanged: (isExpanded) {
                                          setState(() {
                                            //ToDo()
                                          });
                                        },
                                        children: Constants.categories
                                            .map((key, value) {
                                              return MapEntry(
                                                  key,
                                                  RadioListTile(
                                                      title: Text(value),
                                                      value: value,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .trailing,
                                                      groupValue:
                                                          categoryDropDownValue,
                                                      onChanged:
                                                          (selectedCategory) {
                                                        setState(() {
                                                          categoryDropDownValue =
                                                              selectedCategory!;
                                                          categoryController
                                                              .collapse();
                                                        });
                                                      }));
                                            })
                                            .values
                                            .toList(),
                                      )
                                      /* DropdownButtonFormField<String>(
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
                                      )*/
                                      ,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: SingleChildScrollView(
                                        child: ExpansionTile(
                                          controller: languageController,
                                          title: const Text(
                                            "Language",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                          onExpansionChanged: (isExpanded) {
                                            setState(() {
                                              //ToDo()
                                            });
                                          },
                                          children: Constants.languages
                                              .map((key, value) {
                                                return MapEntry(
                                                    key,
                                                    RadioListTile(
                                                        title: Text(value),
                                                        value: value,
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .trailing,
                                                        groupValue:
                                                            languageDropDownValue,
                                                        onChanged:
                                                            (selectedCategory) {
                                                          setState(() {
                                                            languageDropDownValue =
                                                                selectedCategory!;
                                                            languageController
                                                                .collapse();
                                                          });
                                                        }));
                                              })
                                              .values
                                              .toList(),
                                        ),
                                      )
                                      /*DropdownButtonFormField<String>(
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
                                      )*/
                                      ,
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
                                            newsProvider.getFilteredArticles(
                                                categoryDropDownValue,
                                                countryDropDownValue);
                                            Navigator.pop(context);
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
            child: Consumer<NewsProvider>(builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.error.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.error),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.blue),
                        onPressed: () {
                          switch (newsProvider.currentRequest) {
                            case 0:
                              newsProvider.getArticles();
                            case 1:
                              newsProvider.getSearchedArticles(searchController
                                  .text
                                  .toLowerCase()
                                  .trimRight());
                            case 2:
                              newsProvider.getFilteredArticles(
                                  categoryDropDownValue, countryDropDownValue);
                          }
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else {
                List<Article> articles = [];
                if (value.currentRequest == 0) {
                  articles = value.defaultArticles;
                } else if (value.currentRequest == 1) {
                  articles = value.searchedArticles;
                } else {
                  articles = value.filteredArticles;
                }
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      articleListTile(context, articles[index]),
                  itemCount: articles.length,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
