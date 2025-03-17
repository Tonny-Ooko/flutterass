import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  const EditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController occupationController;
  late TextEditingController bioController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    occupationController = TextEditingController(text: widget.user.occupation);
    bioController = TextEditingController(text: widget.user.bio);
    phoneController = TextEditingController(text: widget.user.phone ?? '');
    addressController = TextEditingController(text: widget.user.address ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    occupationController.dispose();
    bioController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (!_formKey.currentState!.validate()) {
      return; 
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final updatedUser = User(
      id: widget.user.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      occupation: occupationController.text.trim(),
      bio: bioController.text.trim(),
      phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
      address: addressController.text.trim().isNotEmpty ? addressController.text.trim() : null,
      profileImage: widget.user.profileImage,
    );

    try {
      print('Updating User: ${updatedUser.name}');
      await userProvider.updateUser(context, updatedUser);
      print('User Successfully Updated: ${updatedUser.name}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error updating user: $e');
      setState(() {
        _errorMessage = 'Failed to update user. Please try again later.';
      });

      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Update Failed'),
          content: Text('An error occurred while updating the user. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit User',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.user.profileImage != null)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8, spreadRadius: 2),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.user.profileImage!),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
              SizedBox(height: 20),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),

              _buildTextField(nameController, 'Name', Icons.person),
              _buildTextField(emailController, 'Email', Icons.email, keyboardType: TextInputType.emailAddress),
              _buildTextField(occupationController, 'Occupation', Icons.work),
              _buildTextField(bioController, 'Bio', Icons.info, maxLines: 3),
              _buildTextField(phoneController, 'Phone', Icons.phone, keyboardType: TextInputType.phone),
              _buildTextField(addressController, 'Address', Icons.location_on),

              SizedBox(height: 30),

              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: _updateUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          shadowColor: Colors.blueAccent.withOpacity(0.3),
                          elevation: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, color: Colors.white, size: 22),
                            SizedBox(width: 8),
                            Text(
                              'Update User',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey),
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }
}
