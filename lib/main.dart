import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/providers/university_provider.dart';
import 'package:tyba_flutter_challenge/routes.dart';
import 'package:tyba_flutter_challenge/univerity_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final provider = UniversityProvider();
          return provider;
        }),
      ],
      child: MaterialApp(
        routes: ROUTES,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFFD4D5D6),
              secondary: const Color(0xFF040305),
              background: const Color(0xFFF2F1F5)),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<UniversityProvider>().fetchUniversities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          "Lista de universidades",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: UniversityList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
