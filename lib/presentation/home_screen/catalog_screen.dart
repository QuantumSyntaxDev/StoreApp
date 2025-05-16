import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_27/data/services/API.dart';

class catalog_screen extends StatefulWidget {
  final String token;
  final VoidCallback setc;
  const catalog_screen({super.key, required this.token, required this.setc});

  @override
  State<catalog_screen> createState() => _catalog_screenState();
}

class _catalog_screenState extends State<catalog_screen> {
  TextEditingController _search = TextEditingController();
  List<dynamic> _product = [];
  List<dynamic> _filterproduct = [];

  void _filter(String value) {
    final ivalue = value.toLowerCase();
    setState(() {
      _filterproduct =
          _product.where((product) {
            return product['name'].toLowerCase().contains(ivalue);
          }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load();
    _search.addListener(() {
      _filter(_search.text);
    });
  }

  Future<void> _load() async {
    final product = await Api.get_catalog_screen('/products', widget.token);
    setState(() {
      _product = product ?? [];
      _filterproduct = _product;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                  hintText: 'Поиск',
                  hintStyle: theme.textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.8,
                ),
                itemCount: _filterproduct.length,
                itemBuilder: (context, index) {
                  final product = _filterproduct[index];
                  final images = product['images'];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: 'i$index',
                          child: Material(
                            color: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: 150,
                                child: PageView.builder(
                                  itemBuilder: (context, indexs) {
                                    String base = images[indexs];
                                    if (base.contains(',')) {
                                      base = base.split(',')[1];
                                    }
                                    final iimages = base64Decode(base);
                                    return Image.memory(
                                      iimages,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(product['name'])
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
