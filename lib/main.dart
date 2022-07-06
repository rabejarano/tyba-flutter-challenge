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
        tooltip: 'github',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? widgetLeft;
  final Widget? widgetRight;
  final Widget? widgetCenter;
  final Color backgroundColor;
  final List<int> flexs;

  BasicAppBar(
      {this.widgetLeft,
      this.flexs = const [3, 8, 3],
      this.widgetCenter,
      this.widgetRight,
      this.backgroundColor = Colors.red});

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        bottom: false,
        maintainBottomViewPadding: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: flexs[1], child: widgetLeft ?? Container()),
            Expanded(flex: flexs[1], child: widgetCenter ?? Container()),
            Expanded(flex: flexs[2], child: widgetRight ?? Container()),
          ],
        ),
      ),
    );
  }
}
