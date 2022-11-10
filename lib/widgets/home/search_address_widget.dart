import 'package:flutter/material.dart';
import '../../model/place.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }
  final sessionToken;
  static late String address;
  late PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: ListTile(
          leading: const Icon(Icons.search),
        onTap: (){
          address = query;
          Navigator.pop(context);
        },
          title: Text(query)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Object>?>(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
          query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Enter your address'),
      )
          :snapshot.data != null
          ?  ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.location_on),
          title:
          Text((snapshot.data![index] as Suggestion).description),
          onTap: () {
            close(context, snapshot.data![index] as Suggestion);
          },
        ),
        itemCount: snapshot.data!.length,
      )
          : snapshot.data == null ?  Container(child:ListTile(
          onTap: () {
            address = query;
            close(context, null as Suggestion);
          },
          leading: const Icon(Icons.search),
          title: Text(query,style: TextStyle(fontSize: 15),))) :
      Container(child: Text('Loading...')),
    );
  }


}