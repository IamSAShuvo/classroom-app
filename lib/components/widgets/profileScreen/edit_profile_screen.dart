import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image Section
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/profile_avatar.jpeg',
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 16,
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Salman Aziz',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              'Classroom Student',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Input Fields
            _buildTextField(label: 'Name', initialValue: 'Salman Aziz'),
            _buildTextField(label: 'User Name', initialValue: 'salman.aziz'),
            _buildTextField(
                label: 'Email', initialValue: 'salman.aziz@demo.com'),
            _buildDropdownField(label: 'Profession', value: 'Student'),

            const SizedBox(height: 16),

            // ID Field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'ID No',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '0123456AD',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),

            const SizedBox(height: 24),

            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile saved successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for Text Fields
  Widget _buildTextField({required String label, String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        TextFormField(
          initialValue: initialValue,
          decoration: const InputDecoration(
            isDense: true,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Helper function for Dropdown Field
  Widget _buildDropdownField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        DropdownButtonFormField<String>(
          value: value,
          items: const [
            DropdownMenuItem(
              value: 'Student',
              child: Text('Student'),
            ),
            DropdownMenuItem(
              value: 'Teacher',
              child: Text('Teacher'),
            ),
          ],
          onChanged: (newValue) {
            // Handle dropdown selection
          },
          decoration: const InputDecoration(
            isDense: true,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
