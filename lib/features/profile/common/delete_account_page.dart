import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/profile/common/profile/profile_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isDeleting = false;
  bool _showPassword = false;
  final controller = Get.find<ProfileController>();

  void _showDeleteDialog() {
    showDeleteAccountDialog(context, onDelete: _performDeletion);
  }

  void _performDeletion() async {
    setState(() => _isDeleting = true);

    await controller.deleteAccount(_passwordController.text.trim());

    setState(() => _isDeleting = false);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.delete_forever,
                  color: AppColors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                commonText(
                  "Delete Account",
                  size: 22,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                commonText(
                  "Enter your password to confirm deletion. This action cannot be undone.",
                  size: 14,
                  textAlign: TextAlign.center,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed:
                          () => setState(() => _showPassword = !_showPassword),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: commonButton(
                        "Cancel",
                        color: Colors.grey.shade300,
                        textColor: Colors.black,
                        height: 50,
                        boarderRadious: 12,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: commonButton(
                        _isDeleting ? "Deleting..." : "Delete",
                        color: AppColors.red,
                        textColor: Colors.white,
                        height: 50,
                        boarderRadious: 12,

                        onTap:
                            _isDeleting
                                ? null
                                : () {
                                  if (_passwordController.text.isEmpty) {
                                    showSnackBar(
                                   
                                      "Please enter your password.",
                                  
                                    );
                                    return;
                                  }
                                  _showDeleteDialog();
                                },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showDeleteAccountDialog(
  BuildContext context, {
  required VoidCallback onDelete,
}) async {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: commonText(
            "Are you sure?",
            size: 18,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          content: commonText(
            "This action cannot be undone. All your data will be permanently deleted.",
            size: 14,
            textAlign: TextAlign.center,
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: commonButton(
                    "Cancel",
                    color: Colors.grey.shade300,
                    textColor: Colors.black,
                    height: 45,
                    boarderRadious: 12,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: commonButton(
                    "Delete",
                    color: AppColors.red,
                    textColor: Colors.white,
                    height: 45,
                    boarderRadious: 12,
                    onTap: () {
                      Navigator.of(context).pop();
                      onDelete();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
