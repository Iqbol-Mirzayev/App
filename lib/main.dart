import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/auth/auth_page.dart';
import 'presentation/tab/tab_box.dart';
import 'router/router.dart';
import 'utils/constants.dart';
import 'view_models/auth_view_model.dart';
import 'view_models/category_view_model.dart';
import 'view_models/product_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    return MultiProvider(
      providers: [
        Provider<AuthViewModel>(
          create: (_) => AuthViewModel(auth: FirebaseAuth.instance),
        ),
        Provider<CategoryViewModel>(
          create: (_) => CategoryViewModel(fireStore: fireStore),
        ),
        Provider<ProductViewModel>(
          create: (_) => ProductViewModel(fireStore: fireStore),
        ),
        StreamProvider(
          create: (context) => context.read<AuthViewModel>().authState(),
          initialData: null,
        ),
        StreamProvider(
          create: (context) => context.read<AuthViewModel>().userInfoChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        onGenerateRoute: MyRouter.generateRoute,
        initialRoute: mainPage,
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const TabBox();
    }
    return const AuthPage();
  }
}