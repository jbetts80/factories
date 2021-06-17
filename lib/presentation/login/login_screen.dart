import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:factories/domain/repositories/auth_repository.dart';
import 'package:factories/presentation/home/home_screen.dart';
import 'package:factories/presentation/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginBLoC>(
      create: (_) => LoginBLoC(
        auth: Provider.of<AuthRepository>(context, listen: false),
      ),
      builder: (_, __) => Login(),
    );
  }
}

class Login extends StatelessWidget {
  void _login(BuildContext context) async {
    final bloc = Provider.of<LoginBLoC>(context, listen: false);
    await bloc.login();
    if (bloc.isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBLoC>(context, listen: false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/login_background.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/user_placeholder.png',
                    height: 80.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Welcome to factories!',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: bloc.userTextEditController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          hintText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: bloc.passTextEditController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Stack(
                        children: [
                          Container(
                            height: 20.0,
                          ),
                          Consumer<LoginBLoC>(
                            builder: (_, blocListener, __) =>
                                AnimatedPositioned(
                              bottom:
                                  blocListener.showErrorMessage ? 0.0 : 20.0,
                              child: Text('Credentials doesn\'t match!'),
                              duration: Duration(milliseconds: 300),
                            ),
                          ),
                        ],
                      ),
                      Consumer<LoginBLoC>(
                        builder: (_, blocListener, __) => blocListener.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Text(''),
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        child: Consumer<LoginBLoC>(
                          builder: (_, blocListener, __) => ElevatedButton(
                            onPressed: blocListener.isLoading
                                ? null
                                : () => _login(context),
                            child: Text('Login'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
