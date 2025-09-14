# Flutter E-Commerce Mini App

A compact but complete Flutter e-commerce mini-app showcasing:
- Firebase Authentication (email/password)
- Product catalog from DummyJSON[](https://dummyjson.com/products)
- Pagination, search and category filter
- Product detail with related products
- Cart & Wishlist with local persistence (Hive)
- Offline support (cached products + local cart/wishlist)
- State management via `flutter_bloc` (Cubits/Blocs)
- Pull-to-refresh and light/dark theme toggle
- Purple & white gradient theme

## Models Used

*   **ProductModel:** Represents a product with properties such as id, title, description, price, rating, images, and category.

This canvas contains a ready-to-run project skeleton. Open the files in the editor pane to inspect the implementation.

## Quick setup
1. Install Flutter SDK (>=3.0) and set up your device/emulator.
2. Create a Firebase project and add Android/iOS apps. Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and follow Firebase setup steps.
3. In project `android/app` add `google-services.json` and update Gradle files per Firebase docs.
4. Run:
```bash
flutter pub get
flutter run
```

## Notes & decisions
- `DummyJSON` is used for product data (no auth required).
- Firebase Auth handles registration/login. You must configure Firebase for the app and enable Email/Password sign-in.
- Offline persistence uses `hive` (simple and fast). The project serializes product maps rather than registering type adapters to keep the example compact.
- State management uses `flutter_bloc` and Cubits providing Loading/Success/Error/Empty states.
