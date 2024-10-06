import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../business_logic/cubit/phnoe_auth/phone_auth_cubit.dart';
import '../../constants/mycolors.dart';
import '../../constants/strings.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 200.h,
                  child: DrawerHeader(
                    child: buildDrawerHeader(context),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                  ),
                ),
                buildDrawerListItem(
                  leading: Icons.person,
                  onTap: () {},
                  title: 'My Profile',
                ),
                buildDrawerListItemDividers(),
                buildDrawerListItem(
                  leading: Icons.history,
                  title: 'Places history',
                  onTap: () {},
                ),
                buildDrawerListItemDividers(),
                buildDrawerListItem(
                  leading: Icons.settings,
                  onTap: () {},
                  title: 'Settings',
                ),
                buildDrawerListItemDividers(),
                buildDrawerListItem(
                  leading: Icons.help,
                  onTap: () {},
                  title: 'Help',
                ),
                buildDrawerListItemDividers(),
                buildLogOutProvider(context),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    'Follow us',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                buildSocialIcons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDrawerHeader(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => phoneAuthCubit,
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: double.infinity,
            padding: const EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue.shade100,
            ),
            child: Image.network(
              'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            phoneAuthCubit.getLoggedInUser().phoneNumber!,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerListItem({
    required IconData leading,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        leading,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??
          const Icon(
            Icons.arrow_right,
            color: MyColors.blue,
          ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemDividers() {
    return Divider(
      height: 0.h,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async => await _launchURL(url),
      child: Icon(
        icon,
        color: MyColors.blue,
        size: 35.sp,
      ),
    );
  }

  buildLogOutProvider(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => phoneAuthCubit,
      child: buildDrawerListItem(
        leading: Icons.logout,
        title: 'Logout',
        onTap: () async {
          await phoneAuthCubit.logOut();
          if (!context.mounted) return;
          Navigator.of(context).pushReplacementNamed(loginscreen);
        },
        color: Colors.red,
        trailing: const SizedBox.shrink(),
      ),
    );
  }

  buildSocialIcons() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w, bottom: 16.h),
      child: Row(
        children: [
          buildIcon(
            FontAwesomeIcons.github,
            'https://github.com/MoazSayed7',
          ),
          SizedBox(
            width: 15.w,
          ),
          buildIcon(
            FontAwesomeIcons.facebookF,
            'https://www.facebook.com/R.Moaz7',
          ),
          SizedBox(
            width: 15.w,
          ),
          buildIcon(
            FontAwesomeIcons.youtube,
            'https://www.youtube.com/@moazsayed',
          ),
          SizedBox(
            width: 15.w,
          ),
          buildIcon(
            FontAwesomeIcons.linkedinIn,
            'https://www.linkedin.com/in/moazsayed/',
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final Uri myUrl = Uri.parse(url);
    if (!await launchUrl(
      myUrl,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
