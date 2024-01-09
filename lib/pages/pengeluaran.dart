import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/pages/nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PengeluaranPage extends StatelessWidget {
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void resetForm() {
    keteranganController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.light100, // Ganti warna latar belakang
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Catat\nPengeluaran",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.dark100, // Ganti warna teks
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: keteranganController,
                label: "Keterangan",
                // Ganti warna border dan teks pada TextField
                borderColor: ColorPalette.light40,
                textColor: ColorPalette.dark100,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: amountController,
                label: "Jumlah Pengeluaran",
                // Ganti warna border dan teks pada TextField
                borderColor: ColorPalette.light40,
                textColor: ColorPalette.dark100,
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                onPressed: () async {
                  await Supabase.instance.client.from('expense').insert({
                    'amount': int.parse(amountController.text),
                    'description': keteranganController.text,
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => NavPage()));
                },
                text: "Simpan",
                color: ColorPalette.red60, // Ganti warna tombol
              ),
              SizedBox(
                height: 5,
              ),
              AppButton(
                text: "Reset",
                color: ColorPalette.light80,
                textColor: ColorPalette.dark100,
                onPressed: () {
                  resetForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
