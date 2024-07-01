import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_mobile/viewmodels/makeup_list_viewmodel.dart';
import 'package:uas_mobile/viewmodels/user_viewmodel.dart';
import 'package:uas_mobile/pages/makeup_detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFD07A7F),
          title: Text(
            'Makeup List',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                await Navigator.pushNamed(context, '/search');
                Provider.of<MakeupListViewModel>(context, listen: false).fetchMakeups();
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<UserViewModel>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<MakeupListViewModel>(context, listen: false).fetchMakeups(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.error != null) {
              return Center(child: Text('An error occurred!'));
            } else {
              return Consumer<MakeupListViewModel>(
                builder: (ctx, viewModel, child) => ListView.builder(
                  itemCount: viewModel.makeups.length,
                  itemBuilder: (ctx, index) {
                    final makeup = viewModel.makeups[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image.network(
                                makeup.imageLink,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            makeup.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            makeup.brand,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          SizedBox(height: 8.0),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MakeupDetailPage(makeup: makeup),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Details',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFFD07A7F),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
