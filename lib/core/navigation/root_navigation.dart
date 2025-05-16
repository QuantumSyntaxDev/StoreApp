import 'package:flutter/material.dart';
import 'package:flutter_application_27/presentation/home_screen/catalog_screen.dart';
import 'package:flutter_application_27/presentation/profile_screen/profile_screen.dart';
import 'package:flutter_application_27/presentation/trash_scren/trash_scren.dart';

class root_navigation extends StatefulWidget {
  final String token;
  final VoidCallback setn;
  const root_navigation({super.key, required this.setn, required this.token});

  @override
  State<root_navigation> createState() => _root_navigationState();
}

class _root_navigationState extends State<root_navigation> {
  int _sel = 0;
  void _ontap(int index) {
    setState(() {
      _sel = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _sel,
        onTap: _ontap,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.call_to_action),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate_sharp),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
      body: IndexedStack(
        index: _sel,
        children: [
          catalog_screen(token: widget.token, setc: widget.setn),
          trash_screen(sett: widget.setn),
          profile_screen(setp: widget.setn),
        ],
      ),
    );
  }
}
