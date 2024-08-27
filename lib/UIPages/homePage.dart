import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current Firebase user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is signed in
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user is signed in'),
        ),
      );
    }

    final String userName = user.displayName ?? 'No Name';
    final String userEmail = user.email ?? 'No Email';
    final String userImageUrl = user.photoURL ??
        'https://www.demoreelsnyc.com/uploads/5/1/2/1/5121840/editor/mv5bymvknjdiyzgtndy5ns00owu3lwi4ytqtyme3ogiyyzu0ogjlxkeyxkfqcgdeqxvymjmzmtc0odq-v1.jpg?1659644978';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userImageUrl),
              ),
              const SizedBox(height: 20),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle button press, e.g., navigate to a different page
                },
                child: const Text('Navigate to Maps to see Your Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
