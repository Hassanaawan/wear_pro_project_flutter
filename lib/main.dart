import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/admin_screens/admin_home_screen.dart';
import 'package:wear_pro/admin_screens/admin_dashboard_screen.dart';
import 'package:wear_pro/admin_screens/admin_login_screen.dart';
import 'package:wear_pro/admin_screens/admin_success_screen.dart';
import 'package:wear_pro/admin_screens/approval_list_screen.dart';
import 'package:wear_pro/admin_screens/approve_decline_product_screen.dart';
import 'package:wear_pro/buyer_screens/buyer_rating_screen.dart';
import 'package:wear_pro/buyer_screens/delivery_details_screen.dart';
import 'package:wear_pro/buyer_screens/measurement_screen.dart';
import 'package:wear_pro/buyer_screens/tailor_details_screen.dart';
import 'package:wear_pro/buyer_screens/wish_list_screen.dart';
import 'package:wear_pro/onboard_screen.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/providers/chat_provider.dart';
import 'package:wear_pro/providers/check_out_provider.dart';
import 'package:wear_pro/providers/location_provider.dart';
import 'package:wear_pro/providers/product_provider.dart';
import 'package:wear_pro/providers/review_cart_provider.dart';
import 'package:wear_pro/providers/tailor_provider.dart';
import 'package:wear_pro/providers/wishlist_provider.dart';
import 'package:wear_pro/seller_screens/add_product_screen.dart';
import 'package:wear_pro/seller_screens/seller_shop_screen.dart';
import 'package:wear_pro/seller_screens/seller_profile.dart';
import 'package:wear_pro/seller_screens/seller_tailor_screen.dart';
import 'package:wear_pro/seller_screens/shop_details_screen.dart';
import 'package:wear_pro/seller_screens/success_screen.dart';
import 'package:wear_pro/seller_screens/welcome_screen.dart';
import 'package:wear_pro/splash_screen.dart';
import 'buyer_screens/buyer_screens.dart';


// void main() => runApp(WearPro());
Future<void> main() async {
  Provider.debugCheckInvalidValueType=null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TailorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: WearPro(),
    ),
  );
  // WearPro());
}

class WearPro extends StatefulWidget {
  // final user = UserPreferences.myUser;

  @override
  State<WearPro> createState() => _WearProState();
}

class _WearProState extends State<WearPro> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Builder(
      builder: (context) => MaterialApp(
        // home: HomeScreen(),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Wear Pro',
        themeMode: ThemeMode.system,

        // ThemeData(
        //   textTheme: GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        // //   primarySwatch: Colors.blue,
        // //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        // home: ProductScreen(),
        initialRoute: SplashScreen.id,
        routes: {
          // FingerprintPage.id: (context) => FingerprintPage(),
          LoginScreen.id: (context) => LoginScreen(),
          OnBoardScreen.id: (context) => OnBoardScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ProductScreen.id: (context) => ProductScreen(),
          MenClothScreen.id: (context) => MenClothScreen(),
          WomenClothScreen.id: (context) => WomenClothScreen(),
          KidsClothScreen.id: (context) => KidsClothScreen(),
          HomemadeClothScreen.id: (context) => HomemadeClothScreen(),
          TailorDetailScreen.id: (context) => TailorDetailScreen(''),
          SellerTailorScreen.id: (context) => SellerTailorScreen(''),
          MeasurementScreen.id: (context) => MeasurementScreen(),
          ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
          StoresScreen.id: (context) => StoresScreen(''),
          CartScreen.id: (context) => CartScreen(),
          BuyerSuccessScreen.id: (context) => BuyerSuccessScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          PaymentScreen.id: (context) => PaymentScreen(),
          WishListScreen.id: (context) => WishListScreen(),
          DeliveryDetailsScreen.id: (context) => DeliveryDetailsScreen(),
          BuyerRatingScreen.id: (context) => BuyerRatingScreen(),
          'EditProfileScreen': (context) => EditProfileScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          SplashScreen.id: (context) => SplashScreen(),
          ShopDetailsScreen.id: (context) => ShopDetailsScreen(),
          // ShopScreen.id: (context) => ShopScreen(),
          SellerShopScreen.id: (context) => SellerShopScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          SuccessScreen.id: (context) => SuccessScreen(),
          SellerProfileScreen.id: (context) => SellerProfileScreen(),
          AdminLoginScreen.id: (context) => AdminLoginScreen(),
          AdminHomeScreen.id: (context) => AdminHomeScreen(),
          AdminDashboardScreen.id: (context) => AdminDashboardScreen(),
          AdminSuccessScreen.id: (context) => AdminSuccessScreen(),
          OrderScreen.id: (context) => OrderScreen(),
          ApprovalListScreen.id: (context) => ApprovalListScreen(),
          ApproveDeclineProductScreen.id: (context) =>
              ApproveDeclineProductScreen(),

        },
      ),
    );
  }
}
