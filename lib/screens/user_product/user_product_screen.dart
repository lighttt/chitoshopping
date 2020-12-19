import 'package:chito_shopping/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Products>(context, listen: false).fetchUserProduct(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : snapshot.hasError
                ? Center(child: Text("Something went wrong!"))
                : ListView.builder(
                    itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data[index].imageURL),
                            radius: 40,
                          ),
                          title: Text("${snapshot.data[index].title}")),
                    ),
                    itemCount: snapshot.data.length,
                  );
      },
    );
  }
}
