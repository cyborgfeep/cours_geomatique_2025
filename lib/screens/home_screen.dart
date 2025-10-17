import 'package:cours_geomatique_2025/models/menu.dart';
import 'package:cours_geomatique_2025/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAmountVisible = true;
  List<Menu> menuList = [
    Menu(color: Colors.deepPurple, name: "Transfert", icon: Icons.person),
    Menu(color: Colors.amber, name: "Paiements", icon: Icons.shopping_cart),
    Menu(color: Colors.blue, name: "Crédit", icon: Icons.phone_android),
    Menu(color: Colors.red, name: "Banque", icon: Icons.account_balance),
    Menu(color: Colors.purpleAccent, name: "Carte", icon: Icons.credit_card),
    Menu(color: Colors.green, name: "Cadeaux", icon: Icons.card_giftcard),
    Menu(color: Colors.pinkAccent, name: "Coffre", icon: Icons.lock),
    Menu(color: Colors.orange, name: "Transport", icon: Icons.directions_bus),
  ];
  List<Transaction> tList = [
    Transaction(
      name: 'Depot',
      amount: 10000,
      dateTime: DateTime.now(),
      type: TransactionType.depot,
    ),
    Transaction(
      name: 'Retrait',
      amount: 15000,
      dateTime: DateTime.now().add(Duration(days: -1)),
      type: TransactionType.retrait,
    ),
    Transaction(
      name: 'Paiement',
      amount: 5000,
      dateTime: DateTime.now().add(Duration(days: -2)),
      type: TransactionType.paiement,
    ),
    Transaction(
      name: 'Bamba FALL 77 777 77 77',
      amount: 10000,
      dateTime: DateTime.now().add(Duration(days: -3)),
      type: TransactionType.envoi,
    ),
    Transaction(
      name: 'Bamba Diop 77 777 77 78 🇸🇳',
      amount: 10000,
      dateTime: DateTime.now().add(Duration(days: -3)),
      type: TransactionType.reception,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            elevation: 2,
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
              onPressed: () {
                print("Settings");
              },
              icon: Icon(Icons.settings, size: 30, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    isAmountVisible = !isAmountVisible;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isAmountVisible ? "10.000F" : "•••••••••",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      !isAmountVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(color: Colors.deepPurple),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      cardWidget(),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: menuList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Menu m = menuList[index];
                          return optionWidget(m);
                        },
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.grey.withValues(alpha: .3),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: tList.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Transaction t = tList[index];
                          return transactionWidget(t);
                        },
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, color: Colors.deepPurple),
                            SizedBox(width: 5),
                            Text(
                              "Rechercher",
                              style: GoogleFonts.dmSans(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardWidget() {
    return GestureDetector(
      onTap: () {
        /*Permet d'aller d'une page vers une
        autre avec l'option de fermer la page precedente*/
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ScanScreen()),
          (route) => true,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        width: 400,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
          ),
        ),
        child: Center(
          child: Container(
            width: 120,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 105,
                  height: 105,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: PrettyQrView.data(
                    data:
                        'google.comhddhtgdhfhfghfhhdgfhgfdhfgddhfgdhgfgfhgfhfghgfhfghhgfhgfhgfhfghf',
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 15),
                    SizedBox(width: 5),
                    Text("Scanner"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionWidget(Transaction t) {
    bool isMinus =
        t.type == TransactionType.retrait ||
            t.type == TransactionType.envoi ||
            t.type == TransactionType.paiement
        ? true
        : false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.name,
                style: GoogleFonts.dmSans(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${isMinus ? "-" : ""}${t.amount}F',
                style: GoogleFonts.dmSans(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            DateFormat('dd MMMM yyyy à HH:mm').format(t.dateTime),
            style: GoogleFonts.dmSans(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  optionWidget(Menu m) {
    return GestureDetector(
      onTap: () {
        print("Allez vers ${m.name}");
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: m.color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Icon(m.icon, color: m.color, size: 35),
          ),
          SizedBox(height: 4),
          Text(m.name, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
