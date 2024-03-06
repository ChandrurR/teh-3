import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balanced Substrings',
      home: BalancedSubstringsScreen(),
    );
  }
}
class BalancedSubstringsScreen extends StatefulWidget {
  const BalancedSubstringsScreen({super.key});
  @override
  _BalancedSubstringsScreenState createState() => _BalancedSubstringsScreenState();
}
class _BalancedSubstringsScreenState extends State<BalancedSubstringsScreen> {
  final TextEditingController _inputController = TextEditingController();
  List<String> balancedSubstrings = [];
  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
  void _calculateBalancedSubstrings() {
    String input = _inputController.text;
    setState(() {
      balancedSubstrings = getBalancedSubstrings(input);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: const Icon(Icons.menu),
        title: const Text('Balanced Substrings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border:OutlineInputBorder(),
                labelText: 'Enter a string'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.greenAccent)),
              onPressed: _calculateBalancedSubstrings,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'The Output String are :',
              style: TextStyle(fontSize: 18,color: Colors.redAccent),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: balancedSubstrings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(balancedSubstrings[index]),
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
List<String> getBalancedSubstrings(String S) {
  List<String> longestBalancedSubstrings = [];
  int maxLen = 0;
  for (int i = 0; i < S.length; i++) {
    for (int j = i + 2; j <= S.length; j++) { 
      String substring = S.substring(i, j); 
      if (_isBalanced(substring)) { 
        if (substring.length > maxLen) { 
          maxLen = substring.length;
          longestBalancedSubstrings = [substring];
        } else if (substring.length == maxLen) {
          longestBalancedSubstrings.add(substring);
        }
      }
    }
  }
  return longestBalancedSubstrings;
}
bool _isBalanced(String substring) {
  Map<String, int> charCount = {};
  for (int i = 0; i < substring.length; i++) {
    charCount[substring[i]] = (charCount[substring[i]] ?? 0) + 1;
  }
  if (charCount.keys.length != 2) return false;
  List<int> counts = charCount.values.toList();
  return counts[0] == counts[1];
}