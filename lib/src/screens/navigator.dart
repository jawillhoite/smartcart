import 'package:collection/collection.dart';

import 'sign_in.dart';
import 'register.dart';
import '../auth.dart';

//import '../data.dart';
//import '../data/library.dart';
import '../routing.dart';
import '../screens/sign_in.dart';
import '../widgets/fade_transition_page.dart';
//import 'author_details.dart';
//import 'book_details.dart';
import 'scaffold.dart';

import 'package:flutter/material.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class ShoppingListNavigator extends StatefulWidget {
  @override
  _ShoppingListNavigatorState createState() => _ShoppingListNavigatorState();

  final GlobalKey<NavigatorState> navigatorKey;

  const ShoppingListNavigator({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);
}

class _ShoppingListNavigatorState extends State<ShoppingListNavigator> {
  // final _signInKey = const ValueKey('Sign in');
  // final _createA = const ValueKey('Create Account');
  // final _scaffoldKey = const ValueKey<String>('App scaffold');
  // final _bookDetailsKey = const ValueKey<String>('Book details screen');
  // final _authorDetailsKey = const ValueKey<String>('Author details screen');

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggleView: toggleView);
    } else {
      return RegisterScreen(toggleView: toggleView);
    }
    //   final routeState = RouteStateScope.of(context);
    //   final authState = ShoppingListAuthScope.of(context);

    //   return Navigator(
    //     key: widget.navigatorKey,
    //     onPopPage: (route, dynamic result) {
    //       // When a page that is stacked on top of the scaffold is popped, display
    //       // the /books or /authors tab in ShoppingListScaffold.
    //       if (route.settings is Page &&
    //           (route.settings as Page).key == _bookDetailsKey) {
    //         routeState.go('/books/popular');
    //       }

    //       if (route.settings is Page &&
    //           (route.settings as Page).key == _authorDetailsKey) {
    //         routeState.go('/authors');
    //       }

    //       return route.didPop(result);
    //     },
    //     pages: [
    //       if (routeState.route.pathTemplate == '/signin')
    //         // Display the sign in screen.
    //         FadeTransitionPage<void>(
    //           key: _signInKey,
    //           child: SignInScreen(
    //             onSignIn: (credentials) async {
    //               var signedIn = await authState.signIn(
    //                   credentials.username, credentials.password);
    //               if (signedIn) {
    //                 routeState.go('/home');
    //               }
    //             },
    //           ),
    //         )

    //       // else if (routeState.route.pathTemplate == '/createAccount')
    //       //   // Display the sign in screen.
    //       //   FadeTransitionPage<void>(
    //       //     key: _createA,
    //       //     child: createAccountScreen(
    //       //       onCreateAccount: (credentials) async {
    //       //         var createAccount = await authState.createAcc(
    //       //             credentials.username, credentials.password);
    //       //         if (createAccount) {
    //       //           routeState.go('/home');
    //       //         }
    //       //       },
    //       //     ),
    //       //   )

    //       else ...[
    //         // Display the app
    //         FadeTransitionPage<void>(
    //           key: _scaffoldKey,
    //           child: const ShoppingListScaffold(),
    //         ),
    //         // Add an additional page to the stack if the user is viewing a book
    //         // or an author
    //         //if (selectedBook != null)
    //         //  MaterialPage<void>(
    //         //    key: _bookDetailsKey,
    //         //    child: BookDetailsScreen(
    //         //      book: selectedBook,
    //         //    ),
    //         //  )
    //         //else if (selectedAuthor != null)
    //         //  MaterialPage<void>(
    //         //    key: _authorDetailsKey,
    //         //    child: AuthorDetailsScreen(
    //         //      author: selectedAuthor,
    //         //    ),
    //         //  ),
    //       ],
    //     ],
    //   );
  }
}
