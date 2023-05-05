

// class IsUser extends StatelessWidget {
//   const IsUser({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // chageUser() async {
//     //   final prefs = await SharedPreferences.getInstance();
//     //   bool? isUser = await prefs.getBool("isUser");
//     //   prefs.get(key)
//     //   return isUser! ? const UserProfile() : WebProfile();
//     // }

//     return Consumer(builder: (context, ref, child) {
//       final isUser = ref(getchangeUser);

//       return isUser.when(data: (value) {
//         return value["isStoreOwner"] ? UserProfile() : WebProfile();
//       }, loading: () {
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       }, error: (stack, erorr) {
//         return const Center(child: Text("Profile Error"));
//       });
//     });
//   }
// }
