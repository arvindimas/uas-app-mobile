import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/pages/nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PemasukanPage extends StatelessWidget {
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void resetForm() {
    keteranganController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Catat\nPemasukan",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: keteranganController,
                label: "Keterangan",
                borderColor: ColorPalette.light40,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: amountController,
                label: "Jumlah Pemasukan",
                borderColor: ColorPalette.light40,
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                onPressed: () async {
                  await Supabase.instance.client.from('income').insert({
                    'amount': int.parse(amountController.text),
                    'description': keteranganController.text,
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => NavPage()));
                },
                text: "Simpan",
                color: ColorPalette.green80,
              ),
              SizedBox(
                height: 5,
              ),
              AppButton(
                text: "Reset",
                color: Colors.grey.shade200,
                textColor: Colors.black,
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
