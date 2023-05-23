import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_typehead/data/data.dart';
import 'package:flutter_typehead/screen/product_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.5),
        title: const Text("DevDiariesWithVee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            setAutocompelete(),
            const SizedBox(
              height: 60,
            ),
            setProductSearch()
          ],
        ),
      ),
    );
  }

  setAutocompelete() {
    return TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: const InputDecoration(labelText: 'Enter Your State'),
          controller: _typeAheadController,
        ),
        suggestionsCallback: (pattern) async {
          return StateService.getSuggestions(pattern);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (suggestion) {
          _typeAheadController.text = suggestion;
        });
  }

  setProductSearch() {
    return TypeAheadField(
      textFieldConfiguration: const TextFieldConfiguration(
        style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintStyle: TextStyle(fontSize: 16),
            hintText: 'What are you looking for?'),
      ),
      suggestionsCallback: (pattern) async {
        return ProductService.getSuggestions(pattern);
      },
      itemBuilder: (context, Map<String, String> suggestion) {
        return ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: Text(suggestion['name']!),
          subtitle: Text('\$${suggestion['price']}'),
        );
      },
      onSuggestionSelected: (Map<String, String> suggestion) {
        Navigator.of(context).push<void>(MaterialPageRoute(
            builder: (context) => ProductPage(suggestion: suggestion)));
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 8.0,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}

