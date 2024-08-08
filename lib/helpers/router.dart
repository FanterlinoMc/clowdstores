import 'package:clowdstores/Widgets/Froms/post_from.dart';
import 'package:clowdstores/ui/pages/shopping_feed.dart';
import 'package:clowdstores/ui/store/dash_bord.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Widgets/Froms/add_business_from.dart';
import '../Widgets/Froms/edit_product.dart';
import '../Widgets/Froms/product.dart';
import '../Widgets/Froms/product_type.dart';
import '../Widgets/Froms/sgingIn_page.dart';
import '../Widgets/Froms/user_from.dart';
import '../Widgets/navigation_bar.dart';
import '../Widgets/tab.dart';
import '../ui/categroise/categroise.dart';
import '../ui/pages/StoerViews/peowfile_view.dart';
import '../ui/pages/User/cart.dart';
import '../ui/pages/User/free_user.dart';
import '../ui/pages/User/orders.dart';
import '../ui/pages/chat_list.dart';
import '../ui/pages/more.dart';
import '../ui/pages/near_me_page.dart';
import '../ui/pages/profile/profile_page.dart';
import '../ui/pages/review_page.dart';
import '../ui/pages/search_page.dart';
import '../ui/pages/welcome_page.dart';
import '../ui/store/orders.dart';
import '../ui/store/products/checkout.dart';
import '../ui/store/products/detail_page.dart';
import '../ui/store/products/product_view.dart';
import '../ui/subPages/chat_screen.dart';
import 'privacy _policy .dart';
import 'splash_screen.dart';

final GoRouter clowdRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return kIsWeb ? const MyTab() : const MyCustomSplashScreen();
      },
    ),
    GoRoute(
      path: '/chatPage',
      name: "chatPage",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: ChatPage(messages: state.extra),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/Profile',
      name: "Profile",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const Profile(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/CartPage',
      name: "CartPage",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const CartPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/UserProfile',
      name: "UserProfile",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const UserProfile(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/ChatList',
      name: "ChatList",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: ChatList(senderInfo: state.extra),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
      builder: (BuildContext context, GoRouterState state) {
        return ChatList(
          senderInfo: state.extra,
        );
      },
    ),
    GoRoute(
      path: '/Home',
      name: "Home",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const ShoppingFeed(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/Moer',
      name: "Moer",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const More(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/NearMe',
      name: "NearMe",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const NearMe(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/ReviewPage',
      name: "ReviewPage",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: ReviewPage(
            storeInfo: state.extra,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/SearchScreen',
      name: "SearchScreen",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const SearchScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/OpeningView',
      name: "OpeningView",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const OpeningView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/DetaliPage',
      name: "DetaliPage",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const DetaliPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    // GoRoute(
    //   path: '/UserState',
    //   name: "UserState",
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    // transitionDuration: Duration(milliseconds: 100),
    //       child: UserState(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         // Change the opacity of the screen using a Curve based on the the animation's
    //         // value
    //         return ScaleTransition(
    //           alignment: Alignment.bottomCenter,
    //           scale: animation,
    //           child: FadeTransition(
    //             opacity: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),
    GoRoute(
      path: '/SgingInPage',
      name: "SgingInPage",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const SgingInPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/UserLogIn',
      name: "UserLogIn",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const UserLogIn(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/AddBusiness',
      name: "AddBusiness",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const AddBusiness(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/NaviBar',
      name: "NaviBar",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const NaviBar(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/Categories',
      name: "Categories",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const Categories(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/OrderPage',
      name: "OrderPage",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const OrderPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/AddProduct',
      name: "AddProduct",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: AddProduct(storeInfo: state.extra),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/EditProduct',
      name: "EditProduct",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: EditProduct(
            updateProduct: state.extra,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/ProductView',
      name: "ProductView",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const ProductView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/DashBrod',
      name: "DashBrod",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: DashBrod(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/ProfileView',
      name: "ProfileView",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: ProfileView(
            storeIdProfile: state.name,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/ProductType',
      name: "ProductType",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const ProductType(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/Privacy',
      name: "Privacy",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const Privacy(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/AddPost',
      name: "AddPost",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const AddPost(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/CheckOut',
      name: "CheckOut",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const CheckOut(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/UserOrders',
      name: "UserOrders",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          // transitionDuration: Duration(milliseconds: 100),
          child: const UserOrders(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
  ],
);
