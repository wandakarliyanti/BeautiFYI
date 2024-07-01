import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_mobile/viewmodels/makeup_list_viewmodel.dart';
import 'makeup_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  void _searchMakeups(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<MakeupListViewModel>(context, listen: false).searchMakeups(query);
    } catch (e) {
      // Handle error if needed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    Provider.of<MakeupListViewModel>(context, listen: false).clearSearch();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD07A7F),
        title: Text(
          'Search Makeup',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMakeups(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                _searchMakeups(value);
              },
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<MakeupListViewModel>(
                builder: (ctx, viewModel, child) {
                  if (viewModel.makeups.isEmpty) {
                    return Center(child: Text('No results found.'));
                  }
                  return ListView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
