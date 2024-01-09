import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/components/expense.dart';
import 'package:flutter_application_1/components/income.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool isIncomeMode = true;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pengeluaranList = [];
  List<Map<String, dynamic>> pemasukanList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // Fetch Pengeluaran
    dynamic pengeluaranResponse = await Supabase.instance.client
        .from('expense')
        .select<List<Map<String, dynamic>>>();
    setState(() {
      pengeluaranList = pengeluaranResponse;
    });

    // Fetch Pemasukan
    dynamic pemasukanResponse = await Supabase.instance.client
        .from('income')
        .select<List<Map<String, dynamic>>>();
    setState(() {
      pemasukanList = pemasukanResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: ColorPalette.light100,
        primaryColor: ColorPalette.dark25,
      ),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Catatan\nKelola Uang",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.dark50,
                      ),
                    ),
                    Switch(
                      value: isIncomeMode,
                      onChanged: (value) {
                        setState(() {
                          isIncomeMode = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTotalCard(
                    "Total ${isIncomeMode ? 'Pemasukan' : 'Pengeluaran'}",
                    isIncomeMode ? ColorPalette.green60 : ColorPalette.red60,
                    isIncomeMode ? calculateTotalIncome() : calculateTotalExpense()),
                SizedBox(height: 10),
                Text(
                  isIncomeMode ? "Daftar Pemasukan" : "Daftar Pengeluaran",
                  style: TextStyle(
                    color: ColorPalette.dark100,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                ...(isIncomeMode
                    ? pemasukanList.map((item) => IncomeComponent(transaction: item))
                    : pengeluaranList.map((item) => ExpenseComponent(transaction: item))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalCard(
      String title, Color backgroundColor, String totalAmount) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorPalette.light100,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "Rp $totalAmount",
            style: TextStyle(
              color: ColorPalette.light100,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  String calculateTotalExpense() {
    double total = 0;
    for (var expense in pengeluaranList) {
      total += expense['amount'];
    }
    return total.toString();
  }

  String calculateTotalIncome() {
    double total = 0;
    for (var income in pemasukanList) {
      total += income['amount'];
    }
    return total.toString();
  }
}
