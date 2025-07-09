import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedPayment = 'Transfer Bank';
  final List<String> paymentMethods = ['Transfer Bank', 'ShopeePay', 'DANA'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'InterSemiBold',
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama
              buildLabel('Nama Penerima'),
              buildTextField(nameController, 'Masukkan nama'),

              const SizedBox(height: 12),
              buildLabel('Nomor HP'),
              buildTextField(
                phoneController,
                '08xxxxxx',
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 12),
              buildLabel('Alamat Lengkap'),
              buildTextField(
                addressController,
                'Masukkan alamat lengkap',
                maxLines: 3,
              ),

              const SizedBox(height: 12),
              buildLabel('Catatan (Opsional)'),
              buildTextField(
                noteController,
                'Contoh: Rumah warna putih',
                maxLines: 2,
              ),

              const SizedBox(height: 24),
              const Divider(),

              const SizedBox(height: 12),
              buildLabel('Metode Pembayaran'),

              ...paymentMethods.map((method) {
                return RadioListTile(
                  value: method,
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                  title: Text(
                    method,
                    style: const TextStyle(fontFamily: 'InterMedium'),
                  ),
                  activeColor: const Color(0xFF2C5364),
                );
              }).toList(),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showSuccessDialog();
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    'Pesan Sekarang',
                    style: TextStyle(fontFamily: 'InterSemiBold'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C5364),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontFamily: 'InterSemiBold', fontSize: 14),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'InterMedium'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 60),
                  SizedBox(height: 16),
                  Text(
                    'Pesanan Berhasil!',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'InterSemiBold',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Terima kasih, pesanan Anda sedang diproses.',
                    style: TextStyle(
                      fontFamily: 'InterMedium',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Tutup dialog
      Navigator.of(context).pop(); // Kembali ke sebelumnya
    });
  }
}
