import 'package:cache_manager/cache_manager.dart';
import 'package:clowdstores/helpers/change_notifiiers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../Data/fire_store_streams.dart';
import '../../helpers/upload_phtoto.dart';
import '../button.dart';
import '../coming_soon.dart';
import '../text-styles.dart';
import '../text_filed.dart';

class AddPost extends StatefulWidget {
  final dynamic storeInfo;
  final dynamic postImage;
  const AddPost({super.key, this.storeInfo, this.postImage});

  @override
  State<AddPost> createState() => _ProductState();
}

class _ProductState extends State<AddPost> {
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _description.dispose();

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
                        Container(
                          height: 20,
                        ),
                        const Column(
                          children: [
                            PostUplaodPage(),
                          ],
                        ),
                        CloudButton(
                          color: validators.qunantiyy
                              ? appBarColor
                              : Colors.blueGrey,
                          name: "Post",
                          onPressed: () async {
                            // _quantity.clear();
                            post.changeStoreName(
                                await ReadCache.getString(key: "name"));
                            post.changeStoreProfile(
                                await ReadCache.getString(key: "photoUrl"));
                            post.changePostCategory(
                                await ReadCache.getString(key: "routeId"));
                            // post.changeLikePost("ClowdStores");
                            post.savePost();
                            _description.clear();
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
