import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/change_notifiiers.dart';
import '../button.dart';
import '../text-styles.dart';
import '../text_filed.dart';

class ProductType extends StatefulWidget {
  const ProductType({
    super.key,
  });

  @override
  State<ProductType> createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {
  final TextEditingController _productTypeController0 = TextEditingController();
  final TextEditingController _productTypeController1 = TextEditingController();
  final TextEditingController _productTypeController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final product = ref.watch(productPro);
      final validators = ref.read(validatorProvider);
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Add Products Categories",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),

          // leadingWidth: size.width / 4,
          // leading:
          backgroundColor: kIsWeb ? Colors.white : appBarColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Add your product Categories",
                  style: TextStyle(
                    fontSize: 25,
                    color: appBarColor,
                  ),
                ),
              ),
              MyTextfiled(
                width: 400,
                color: validators.productType0 ? appBarColor : Colors.green,
                validator: (value) => validators.isValidproductType0(value!),
                controller: _productTypeController0,
                onChanged: (value) => product.changeProductType0(value),
                labelText: "Frist Product category",
                hintText: "Ex: SmartPhones",
              ),
              MyTextfiled(
                width: 400,
                color: validators.productType1 ? appBarColor : Colors.green,
                validator: (value) => validators.isValidproductType1(value!),
                controller: _productTypeController1,
                onChanged: (value) => product.changeProductType1(value),
                labelText: "Second Product category",
                hintText: "Ex: accessories",
              ),
              MyTextfiled(
                width: 400,
                color: validators.productType2 ? appBarColor : Colors.green,
                validator: (value) => validators.isValidproductType2(value!),
                controller: _productTypeController2,
                onChanged: (value) => product.changeProductType2(value),
                labelText: "Third Product category",
                hintText: "Ex: Laptops",
              ),
              CloudButton(
                  name: "Done",
                  onPressed: () {
                    product.createProductType();
                    context.go('/');
                  })
            ],
          ),
        ),
      );
    });
  }
}
