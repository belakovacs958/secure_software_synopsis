
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' as platform;
import '../../../../utils/route_names.dart';
import '../bloc/vendor_account_bloc.dart';
import '../bloc/vendor_account_event.dart';
import '../bloc/vendor_account_state.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailField = '';
  String passwordField = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ScrollController scrollController = ScrollController();
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffE8D6F4),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AccountBloc>(context).add(
                            FacebookLoginEvent(),
                          );
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                color: colorScheme.primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Log in with Google",
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),

                BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    if (state is LoadedAccount) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => {
                          if (Navigator.of(context).canPop())
                            {Navigator.of(context).pop()}
                          else
                            {context.goNamed(CONTACTS_PAGE)}
                        },
                      );
                    } else if (state is LoadingAccount) {
                      return Center(
                        child: SpinKitCircle(
                          color: colorScheme.primary,
                          size: 30,
                        ),
                      );
                    } else if (state is ErrorAccount) {
                      return Center(
                        child: Text(
                          "Sign in failed",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    return Text('');
                  },
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
