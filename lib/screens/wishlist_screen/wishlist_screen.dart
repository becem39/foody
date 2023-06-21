import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/consts/consts.dart';
import 'package:foody/services/firestore_services.dart';
import '../../widgets/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: redColor,
        title:
            "My wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "wishlist is empty !"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
          
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: Image.network(
                            '${data[index]['p_images'][0]}',
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: '${data[index]['p_name']} '
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: '${data[index]['p_price']} TND'
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ).onTap(() async {
                            await firestore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              "p_wishlist":
                                  FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          }),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
