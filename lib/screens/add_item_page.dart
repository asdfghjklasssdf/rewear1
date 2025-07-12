import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _categoryController = TextEditingController();
  final _typeController = TextEditingController();
  final _sizeController = TextEditingController();
  final _conditionController = TextEditingController();
  final _tagsController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final ref = FirebaseDatabase.instance.ref();
      final itemRef = ref.child('items').push();

      await itemRef.set({
        'title': _titleController.text.trim(),
        'description': _descController.text.trim(),
        'category': _categoryController.text.trim(),
        'type': _typeController.text.trim(),
        'size': _sizeController.text.trim(),
        'condition': _conditionController.text.trim(),
        'tags': _tagsController.text.trim().split(','),
        'uploadedBy': 'user_1',
        'status': 'pending',
      });

      await ref.child('pendingApprovals/${itemRef.key!}').set(true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item submitted for approval')),
      );

      Navigator.pop(context);
    }
  }

  Widget _buildLabeledField({
    required String title,
    required TextEditingController controller,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
            ),
            validator: (val) => val!.isEmpty ? 'Required' : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List New Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLabeledField(title: 'Title', controller: _titleController),
              _buildLabeledField(title: 'Description', controller: _descController),
              _buildLabeledField(title: 'Category', controller: _categoryController),
              _buildLabeledField(title: 'Type', controller: _typeController),
              _buildLabeledField(title: 'Size', controller: _sizeController),
              _buildLabeledField(title: 'Condition', controller: _conditionController),
              _buildLabeledField(
                title: 'Tags (comma-separated)',
                controller: _tagsController,
                hint: 'e.g. casual, cotton, blue',
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.upload),
                label: Text(_isSubmitting ? 'Submitting...' : 'Submit Item'),
                onPressed: _isSubmitting ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
