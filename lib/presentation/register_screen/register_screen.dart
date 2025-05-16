import 'package:flutter/material.dart';
import 'package:flutter_application_27/data/services/API.dart';
import 'package:flutter_application_27/presentation/login_screen/login_screen.dart';

class register_screen extends StatefulWidget {
  final VoidCallback setr;
  const register_screen({super.key, required this.setr});

  @override
  State<register_screen> createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  // функции

  // контроллерны
  final TextEditingController _mail = TextEditingController(
    text: 'email@gmail.com',
  );
  final TextEditingController _pass = TextEditingController(
    text: 'email@gmail.com',
  );
  final TextEditingController _login = TextEditingController(
    text: 'email@gmail.com',
  );

  bool _valid = true;
  bool _isValid(String email) {
    final pattern = RegExp(r'^\w+@\w+\.\w+$');
    return pattern.hasMatch(email);
  }

  Future<void> _send() async {
    setState(() {
      _valid = _isValid(_mail.text);
    });

    if (!_valid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ошибка')));
    }
    final res = await Api.post_reg('/register', {
      'mail': _mail.text,
      'password': _pass.text,
      'login': _login.text,
    });

    if (res != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => login_screen(setl: widget.setr),
        ),
      );
    }
  }

  // память что бы не засорялась
  @override
  void dispose() {
    super.dispose();
    _mail.dispose();
    _pass.dispose();
    _login.dispose();
  }

  bool _visibl = true;

  @override
  Widget build(BuildContext context) {
    // тема
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _mail,
              decoration: InputDecoration(
                hintText: 'Почта',
                hintStyle: theme.textTheme.bodyMedium,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: _valid ? Colors.green : Colors.red,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: _valid ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _login,
              decoration: InputDecoration(
                hintText: 'Логин',
                hintStyle: theme.textTheme.bodyMedium,
              ),
            ),
            TextField(
              obscureText: _visibl,

              controller: _pass,
              decoration: InputDecoration(
                hintText: 'Почта',
                hintStyle: theme.textTheme.bodyMedium,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _visibl = !_visibl;
                    });
                  },
                  icon: Icon(
                    _visibl ? Icons.visibility : Icons.visibility_off,
                    color: theme.iconTheme.color,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _send,
                    child: Text('Регистрация', style: theme.textTheme.bodyMedium),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
