import 'package:flutter/material.dart';
import 'package:frontend/api/Shoes.dart';
import 'package:frontend/pages/HomePage.dart';

class UpdateProduct extends StatefulWidget {
  final int idShoes;
  const UpdateProduct({super.key, required this.idShoes});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _priceController = TextEditingController();
  final imageController = TextEditingController();
  int id = 0;

   bool _isLoading = false;
   final ShoesController _shoesController = ShoesController();

  Future<void> fetchProduct(id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final shoes = await _shoesController.getShoeById(id);
      setState(() {
        _judulController.text = shoes["title"];
        _deskripsiController.text = shoes["description"];
        imageController.text = shoes["images"];
        _priceController.text = shoes["price"].toString();
      });
    } catch (e) {
      print('Failed to fetch product: $e');
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

   @override
    void initState() {
        super.initState();
        fetchProduct(widget.idShoes);
        id = widget.idShoes;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
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
               FilledButton(
                onPressed: (){
                String title = _judulController.text;
                String price = _priceController.text;
                String image = imageController.text;
                String desc = _deskripsiController.text;

                _shoesController.updateShoes(id,title, desc, price, image).then((value) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                });
                
              }, child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}