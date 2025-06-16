import 'dart:convert';
import 'package:bson/bson.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

const baseUrl = 'http://localhost:3001/snippets';

void main() {
  final String groupObjectId = ObjectId().$oid;
  group('Snippet API Tests', () {
    test('Test: GET /snippets/findAll should return all snippets', () async {
      final response = await http.get(Uri.parse('$baseUrl/findAll'));
      expect(response.statusCode, 200);
      final List snippets = jsonDecode(response.body);
      expect(snippets, isNotEmpty);
    });

    test('GET /snippets/findBy should return snippets by query', () async {
      final response = await http.get(Uri.parse('$baseUrl/findBy?title=Test'));
      expect(response.statusCode, 200);
      final List snippets = jsonDecode(response.body);
      for (var snippet in snippets) {
        expect(snippet['title'], contains('Test'));
      }
    });

    test('POST /snippets/add-one should create a new snippet', () async {
      final snippet = {
        'title': 'Test Snippet',
        'categories': ['test', 'flutter'],
        'body': 'This is a test snippet',
        'id': groupObjectId,
        'createdOn': DateTime.now().toIso8601String(),
        'postedBy': 'Tester'
      };
      final response = await http.post(
        Uri.parse('$baseUrl/add-one'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(snippet),
      );
      expect(response.statusCode, 200);
      final createdSnippet = jsonDecode(response.body);
      expect(createdSnippet['success'], true);
    });


    test('POST /snippets/updateOne should update an existing snippet', () async {
      // replace with an actual snippet id
      final updatedData = {
        'id': groupObjectId,
        'title': 'XXXUpdated Title',
        'categories': ['updated'],
        'body': 'Updated body content',
        'createdOn': DateTime.now().toIso8601String(),
        'postedBy': 'Updater'
      };
      final response = await http.post(
        Uri.parse('$baseUrl/updateOne'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );
      expect(response.statusCode, 200);
      final updatedSnippet = jsonDecode(response.body);
      expect(updatedSnippet['success'], true);
    });

    test('DELETE /snippets/deleteById should delete a snippet by ID', () async {
      final snippetId = groupObjectId; // replace with an actual snippet id
      final response = await http.delete(Uri.parse('$baseUrl/deleteById/$snippetId'));
      expect(response.statusCode, 200);
      final result = jsonDecode(response.body);
      expect(result['success'], true);
    });
    //
    test('POST /snippets/filterItems should filter snippets based on criteria', () async {
      final filterCriteria = {
        'categories': ['flutter']
      };
      final response = await http.post(
        Uri.parse('$baseUrl/filterItems'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(filterCriteria),
      );
      expect(response.statusCode, 200);
      final List filteredSnippets = jsonDecode(response.body);
      for (var snippet in filteredSnippets) {
        expect(snippet['categories'], contains('flutter'));
      }
    });
    //
    // test('GET /snippets/hi should return a simple message', () async {
    //   final response = await http.get(Uri.parse('$baseUrl/hi'));
    //   expect(response.statusCode, 200);
    //   final message = jsonDecode(response.body)['message'];
    //   expect(message, 'Hello, Snippet!');
    // });
  });
}
