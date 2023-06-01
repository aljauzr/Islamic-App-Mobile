import 'package:flutter/material.dart';
import 'package:ta_tpm/http_request/api_data_source.dart';
import 'package:ta_tpm/http_request/doa_model.dart';
import 'detail_doa_screen.dart';
import 'main_screen.dart';
import 'profile_screen.dart';

const primaryColor = Color(0xFF647c64);
const backgroundColor = Colors.white;

class DoaListScreen extends StatefulWidget {
  const DoaListScreen({Key? key}) : super(key: key);

  @override
  _DoaListScreenState createState() => _DoaListScreenState();
}

class _DoaListScreenState extends State<DoaListScreen> {
  String _searchQuery = '';

  // BOTTOM NAVBAR CONDITION
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }
    if (_selectedIndex == 1) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
    }
  }
  // END OF BOTTOM NAVBAR CONDITION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: primaryColor,
          title: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
      ),
      body: _buildDoaListScreenBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: primaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDoaListScreenBody() {
    return Container(
      color: backgroundColor,
      child: FutureBuilder(
        future: ApiDataSource.getDoaList(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            DoaModel doaModel = DoaModel.fromJson(snapshot.data);
            return _buildSuccessSection(doaModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DoaModel data) {
    List<Data> filteredList = data.data!
        .where((dataDoa) =>
        dataDoa.title!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DoaDetailScreen(doa: filteredList![index]),
                  )
              );
            },
            title: Text(filteredList[index].title!),
          ),
        );
      },
    );
  }
}
