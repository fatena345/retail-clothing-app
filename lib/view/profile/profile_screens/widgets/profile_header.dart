import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/model/user/user_model.dart';
import 'package:geeta/widgets/custom_text.dart';


class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final avatar = user?.avatarUrl;
    final hasAvatar = avatar != null && avatar.isNotEmpty;

    return Row(
      children: [
        CircleAvatar(
          radius: AppRadius.r32,
          backgroundColor: AppColors.white.withAlpha(60),
          backgroundImage: hasAvatar ? NetworkImage(avatar) : null,
          child: hasAvatar
              ? null
              : const Icon(Icons.person, color: AppColors.white, size: 32),
        ),
        SizedBox(width: AppWidth.w15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomText(
                      text: user?.name ?? '',
                      fontSize: AppFontSize.s18,
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.white,
                      maxLignes: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: AppWidth.w8),
                  const Icon(Icons.edit_outlined,
                      color: AppColors.white, size: 16),
                ],
              ),
              SizedBox(height: AppHeight.h4),
              CustomText(
                text: user?.email ?? '',
                fontSize: AppFontSize.s12,
                color: AppColors.white.withAlpha(200),
                maxLignes: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
