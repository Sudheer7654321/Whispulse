import 'package:flutter/material.dart';
import 'package:getnew/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      /*appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade600,
          child: Icon(
            HugeIcons.strokeRoundedBackward02,
            color: AppColors.white,
            size: 22,
          ),
        ),
        title: Text(
          'Saved News',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          spacing: 16,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 8,
                    bottom: 8,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade600,
                    child: Icon(
                      HugeIcons.strokeRoundedBackward02,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Text(
                  'Saved News',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.darkgrey,
                        hintText: "Search Saved News",
                        hintStyle: GoogleFonts.outfit(
                          color: Colors.grey.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16),
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightgrey,
                    radius: 22,
                    child: Icon(
                      HugeIcons.strokeRoundedSearch02,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
