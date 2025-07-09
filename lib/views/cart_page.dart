import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;

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
                'Keranjang',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'InterSemiBold',
                  fontSize: 20,
                ),
              ),

              actions: [
                IconButton(
                  icon: const Icon(Icons.payment),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CheckoutPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),

      body:
          cartItems.isEmpty
              ? const Center(
                child: Text(
                  'Keranjang kamu kosong 😢',
                  style: TextStyle(fontSize: 16, fontFamily: 'InterMedium'),
                ),
              )
              : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🖼️ Gambar Produk
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.product.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 70);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 📄 Nama & Harga
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'InterSemiBold',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${item.product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'InterMedium',
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ➕➖ Hapus
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => cart.decreaseQty(item.product),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontFamily: 'InterMedium',
                                fontSize: 14,
                              ),
                            ),
                            IconButton(
                              onPressed: () => cart.increaseQty(item.product),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed:
                                  () => cart.removeFromCart(item.product),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

      // 🔽 Bottom: Total Harga + Tombol Checkout
      bottomNavigationBar:
          cartItems.isNotEmpty
              ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutPage(),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C5364),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontFamily: 'InterSemiBold'),
                      ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
