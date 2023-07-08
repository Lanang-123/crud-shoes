import 'package:flutter/material.dart';
import 'package:frontend/api/Shoes.dart';
import 'package:frontend/pages/HomePage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ShoesController _shoesController = ShoesController();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _priceController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(
                  label: Text('Judul')
                ),
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  label: Text('Deskripsi')
                ),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  label: Text('Harga')
                ),
              ),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(
                  label: Text('Gambar')
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(onPressed: (){
                String title = _judulController.text;
                String price = _priceController.text;
                String image = imageController.text;
                String desc = _deskripsiController.text;

                _shoesController.createShoes(title, desc, price, image).then((value) {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                });
                
              }, child: Text("Tambah"))
            ],
          ),
        ),
      ),
    );
  }
}