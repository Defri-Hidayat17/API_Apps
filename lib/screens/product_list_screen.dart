import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import 'product_detail_screen.dart'; // buat navigasi ke detail produk

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _productFuture;

  // 🧠 ini buat simpen semua produk yang diambil dari API
  List<Product> _allProducts = [];

  // 👀 ini hasil filter pencarian
  List<Product> _filteredProducts = [];

  // 🔍 controller buat input search
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ambil data produk dari API pas halaman dibuka
    _productFuture = ApiService.fetchProducts().then((products) {
      _allProducts = products;
      _filteredProducts = products; // awalnya tampil semua
      return products;
    });
  }

  // 🔄 buat refresh data dari API (misalnya ditekan tombol refresh)
  void _refreshData() {
    setState(() {
      _productFuture = ApiService.fetchProducts().then((products) {
        _allProducts = products;
        _filteredProducts = products;
        _searchController.clear();
        return products;
      });
    });
  }

  // 🧹 biar controller gak bocor memori
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🟩 AppBar gradasi biar keren
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            // background gradasi
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),

            // appbar transparan di atas gradasi
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Daftar Produk',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: _refreshData,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),

      // 🟦 Isi halaman
      body: FutureBuilder<List<Product>>(
        future: _productFuture,
        builder: (context, snapshot) {
          // loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          }

          // kalau ada error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ups! Gagal ambil data:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            );
          }

          // kalau data udah dapet, tampilkan
          return Column(
            children: [
              // 🔍 Search bar
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _filteredProducts = _allProducts;
                                });
                              },
                            )
                            : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {
                      _filteredProducts =
                          _allProducts
                              .where(
                                (product) => product.title
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                    });
                  },
                ),
              ),

              // 🧾 daftar produk (grid)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: _filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          // buka halaman detail pas diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: ProductCard(product: product),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 🟨 Tampilan kartu 1 produk
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // gambar
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              product.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
            ),
          ),

          // nama produk
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // harga
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // deskripsi pendek
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description.length > 50
                  ? '${product.description.substring(0, 50)}...'
                  : product.description,
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
