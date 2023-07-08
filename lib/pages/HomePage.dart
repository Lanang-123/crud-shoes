import 'package:flutter/material.dart';
import 'package:frontend/api/Shoes.dart';
import 'package:frontend/pages/addPage.dart';
import 'package:frontend/pages/updatePage.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formatRupiah(int amount) {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
    customPattern: '###,###',
  );
  return formatCurrency.format(amount);
}

final ShoesController _shoesController = ShoesController();

  List<dynamic> _shoes = [];
  bool _isLoading = false;

  Future<void> fetchProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final shoes = await _shoesController.getShoes();
      setState(() {
        _shoes = shoes;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

   @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) { 
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

  

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD APP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height - 100,
          width: width,
          child: _isLoading ? Center(child: CircularProgressIndicator(),) : 
            GridView.builder(
            itemCount: _shoes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
            ), 
            itemBuilder: (BuildContext context,index) {
              print(_shoes[index]);
              var shoes = _shoes[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    ClipRRect(
                      child: Image.network(shoes["images"],fit: BoxFit.cover, height: 100, width: width,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      child: Text(shoes["title"], style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
      
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      child: Text(formatRupiah(shoes["price"])),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      child: Text(shoes["description"], maxLines: 2,   overflow: TextOverflow.ellipsis,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return UpdateProduct(idShoes: shoes["id"],);
                          }));
                        }, icon: Icon(Icons.edit,color: Colors.amber,)),
                        IconButton(onPressed: (){
                          _shoesController.deleteShoes(shoes["id"]).then((value){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                          });
                        }, icon: Icon(Icons.delete,color: Colors.red,))
                      ],
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddProduct();
        }));
      },child: Icon(Icons.add)),
    );
  }
}


