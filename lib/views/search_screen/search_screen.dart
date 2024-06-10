import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuraga_app/blocs/search/search_screen_bloc.dart';
import 'package:nuraga_app/utils/color/constant.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false, // This removes the default back arrow
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle notification icon press if needed
              },
            ),
            SizedBox(width: 8), // Optional spacing
            Text(
              'Search',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => SearchScreenBloc(),
        child: SearchPage(),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _provinceController = TextEditingController();
  final _cityController = TextEditingController();
  late SearchScreenBloc _searchScreenBloc;

  @override
  void initState() {
    super.initState();
    _searchScreenBloc = context.read<SearchScreenBloc>();
    _provinceController.addListener(_onInputChange);
    _cityController.addListener(_onInputChange);
  }

  @override
  void dispose() {
    _provinceController.removeListener(_onInputChange);
    _cityController.removeListener(_onInputChange);
    _provinceController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onInputChange() {
    if (_formKey.currentState!.validate()) {
      String province = _provinceController.text;
      String city = _cityController.text;
      _searchScreenBloc.add(SearchItems(province: province, city: city));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Masukkan lokasi anda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: kPrimaryGrey,
                ),
                padding:
                    EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _provinceController,
                      decoration: InputDecoration(
                        labelText: 'Province',
                        prefixIcon:
                            Image.asset('assets/images/province_icon.png'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a province';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: Image.asset('assets/images/city_icon.png'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Divider(),
              BlocBuilder<SearchScreenBloc, SearchScreenState>(
                builder: (context, state) {
                  if (state is SearchScreenLoading) {
                    return CircularProgressIndicator();
                  } else if (state is SearchScreenLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          var item = state.items[index].split(':');
                          String hospitalName = item[0];
                          String province = item[1];
                          String city = item[2];
                          String imagePath = item[3];

                          return ListTile(
                            title: Text(hospitalName),
                            subtitle: Text('$province, $city'),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(imagePath),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is SearchScreenError) {
                    return Text(state.error,
                        style: TextStyle(color: Colors.red));
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
