import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../helpers/test.dart';
import '../button.dart';
import '../coming_soon.dart';
import '../text_filed.dart';

class AddPost extends StatefulWidget {
  final dynamic storeInfo;
  const AddPost({Key? key, this.storeInfo}) : super(key: key);

  @override
  State<AddPost> createState() => _ProductState();
}

class _ProductState extends State<AddPost> {
  final TextEditingController _postTitle = TextEditingController();

  final TextEditingController _description = TextEditingController();

  final TextEditingController _postCategory = TextEditingController();

  // final TextEditingController _quantity = TextEditingController();

  // // final TextEditingController _productTypeController = TextEditingController();
  // final TextEditingController _productTypeController0 = TextEditingController();
  // final TextEditingController _productTypeController1 = TextEditingController();
  // final TextEditingController _productTypeController2 = TextEditingController();
  @override
  void dispose() {
    _postTitle.dispose();
    _description.dispose();

    _postCategory.dispose();
    // _quantity.dispose();
    // _productTypeController0.dispose();
    // _productTypeController1.dispose();
    // _productTypeController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: Consumer(builder: (BuildContext context, ref, child) {
      final post = ref.read(postNotifire);
      // final productType = ref.watch(productRow);
      final validators = ref.read(validatorProvider);
      // UploadTask? uploadTask;

      return Center(
        child: SizedBox(
          width:
              ResponsiveValue(context, defaultValue: 500.0, conditionalValues: [
            Condition.smallerThan(name: DESKTOP, value: size.width),
          ]).value,
          child: CustomScrollView(
            slivers: [
              ClowdSliverAppBar(
                title: const Text(
                  "Add Post",
                  style: TextStyle(
                    fontSize: 25,
                    color: kIsWeb ? appBarColor : Colors.white,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 15),
                        // CircleAvatar(
                        //   backgroundImage:
                        //       NetworkImage(product.photoUrl ?? ""),
                        //   backgroundColor: Colors.blue,
                        //   radius: 100,
                        //   child: InkWell(
                        //     onTap: () {
                        //       //  context.refresh(productPro)
                        //       product.changePhoto(
                        //           uploadingTask: uploadTask);
                        //     },
                        //   ),
                        //   // product.photoUrl ?? "",
                        //   // //   color: Colors.blue,
                        //   // handleLoadingProgress: true,
                        //   // height: 80,
                        //   // width: 120,
                        // ),
                        MyTextfiled(
                          color: validators.productName
                              ? appBarColor
                              : Colors.green,
                          validator: (value) =>
                              validators.isProductNameValid(value!),
                          maxLength: 15,
                          labelText: "Name",
                          hintText: "Name",
                          controller: _postTitle,
                          onChanged: (value) => post.changePostTitle(value),
                        ),
                        MyTextfiled(
                          color: validators.desctiotion
                              ? appBarColor
                              : Colors.green,
                          validator: (value) =>
                              validators.isDescription(value!),
                          labelText: "description",
                          hintText: "description",
                          controller: _description,
                          onChanged: (value) => post.changePostcontent(value),
                        ),
                        MyTextfiled(
                          color: validators.price ? appBarColor : Colors.green,
                          validator: (value) => validators.ispriceValid(value!),
                          // keyboardType: TextInputType.,
                          controller: _postCategory,
                          onChanged: (value) => post.changePostCategory(value),
                          labelText: "Category",
                          hintText: "Category",
                        ),
                        // MyTextfiled(
                        //   color: validators.qunantiyy
                        //       ? appBarColor
                        //       : Colors.green,
                        //   validator: (value) =>
                        //       validators.isQuantity(value!),
                        //   keyboardType: TextInputType.number,
                        //   controller: _quantity,
                        //   onChanged: (value) =>
                        //       product.changeQuantity(value),
                        //   labelText: "quantity",
                        //   hintText: "quantity",
                        // ),
                        // const ProDrop(),
                        Container(
                          height: 20,
                        ),
                        const PostUplaodPage(),
                        // CloudButton(
                        //     name: "Pick an Image",
                        //     onPressed: () {
                        //       product.changePhoto();
                        //     }),
                        CloudButton(
                          color: validators.qunantiyy
                              ? Colors.blueGrey
                              : appBarColor,
                          name: "Post",
                          onPressed: () async {
                            post.savePost();

                            _postTitle.clear();
                            _postCategory.clear();
                            _description.clear();
                            // _quantity.clear();
                            return ref.refresh(productPro);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
