import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Scaffold(
        body: getData(),
      ),
    );
  }
}

//### Login User
class loginUser extends StatefulWidget {
  const loginUser({Key? key}) : super(key: key);

  @override
  State<loginUser> createState() => _loginUserState();
}

class _loginUserState extends State<loginUser> {
  TextEditingController loginuser = TextEditingController();
  TextEditingController loginpwd = TextEditingController();
  var mylogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: loginuser,
                decoration: const InputDecoration(
                    hintText: 'name', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: loginpwd,
                decoration: const InputDecoration(
                    hintText: 'passowrd', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(onPressed: loginpost, child: const Text('Login!')),
              const SizedBox(
                height: 25,
              ),
              mylogin == true ? Text('Error user or pwd') : Text('')
            ],
          ),
        ),
      ),
    );
  }

  loginpost() async {
    var url = 'http://127.0.0.1:8000/loginapp/';
    Map<String, String> body = {
      'name': loginuser.text,
      'pwd': loginpwd.text,
    };
    final resp = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    if (resp.statusCode == 200) {
      print('hi');
      setState(() {
        mylogin = false;
      });
    } else if (resp.statusCode == 403) {
      setState(() {
        mylogin = true;
      });
    }
  }
}

//End login User

//### Create User
class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController name = TextEditingController();
  TextEditingController pwdN = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(
                  hintText: 'name', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: pwdN,
              decoration: const InputDecoration(
                  hintText: 'password', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                  hintText: 'email', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton(onPressed: SingUp, child: const Text('Login'))
          ],
        ),
      )),
    );
  }

  SingUp() async {
    var url = 'http://127.0.0.1:8000/sing/';
    Map<String, String> body = {
      'name': name.text,
      'pwd': pwdN.text,
      'email': email.text,
    };

    final resp = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(resp.body);
  }
}

class lnl extends StatefulWidget {
  const lnl({Key? key}) : super(key: key);

  @override
  State<lnl> createState() => _lnlState();
}

class _lnlState extends State<lnl> {
  TextEditingController usr = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: usr,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: pwd,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(onPressed: createPost, child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createPost() async {
    const url = "http://localhost:8000/login";
    Map<String, String> body = {
      'username': usr.text,
      'password': pwd.text,
    };

    final resp = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    var jw = jsonDecode(resp.body);
    if (resp.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error user or password'),
        ),
      );
    } else if (resp.statusCode == 200) {
      jwt(jw['access_token']);
    }
  }

  // Jwt
  Future<void> jwt(var jw) async {
    const url = "http://localhost:8000/user";

    final resp = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $jw"},
    );
    var respbode = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      var respuser = respbode['user'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => prof(
                    name: respuser,
                  )));
    }
  }
}

class getData extends StatefulWidget {
  const getData({Key? key}) : super(key: key);

  @override
  State<getData> createState() => _getDataState();
}

class _getDataState extends State<getData> {
  var xml = false;
  var name = '';
  var resemail = '';
  var phone = '';
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150, left: 150),
            child: TextField(
              controller: email,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          TextButton(onPressed: _get_data, child: const Text('Go!')),
          const SizedBox(
            height: 25,
          ),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: xml == true ? Cardes() : Text(''))
        ],
      )),
    );
  }

  Widget Cardes() {
    return Container(
      child: Column(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.person, size: 25, color: Colors.black),
                  title: Text(name),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.email, size: 25, color: Colors.black),
                  title: Text(resemail),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    leading: const Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text(
                      phone,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _get_data() async {
    var url = 'http://141.95.55.75:9090/db/?kay=${email.text}';
    var resp = await http.get(Uri.parse(url));
    var body = utf8.decode(resp.bodyBytes);
    var js = jsonDecode(body);
    var filterjs = js['Result'];
    print(filterjs);
    setState(() {
      xml = true;
      name = filterjs['name'];
      resemail = filterjs['email'];
      phone = filterjs['phone'];
    });
    email.clear();
  }
}

class apikey extends StatefulWidget {
  const apikey({Key? key}) : super(key: key);

  @override
  State<apikey> createState() => _apikeyState();
}

class _apikeyState extends State<apikey> {
  var responstext = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(20),
                height: 150,
                width: 150,
                child: Center(child: Text('$responstext')),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.red))),
            const SizedBox(
              height: 20,
            ),
            TextButton(onPressed: who, child: const Text('Click!')),
            const Divider(
              thickness: 0.9,
              height: 0.1,
              indent: 150,
              endIndent: 150,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  Future<void> who() async {
    var url =
        'http://127.0.0.1:8000/api/?kay=1b17a7fce81875310f4349db979d2e1d220f589d75d448bcf224945c6225407c';
    var res = await http.get(Uri.parse(url));
    setState(() {
      responstext = res.body;
    });
  }
}

class prof extends StatefulWidget {
  final String name;
  const prof({Key? key, required this.name}) : super(key: key);

  @override
  State<prof> createState() => _profState();
}

class _profState extends State<prof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 55,
            ),
            Text(widget.name)
          ]),
        ),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
