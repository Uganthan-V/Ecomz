# 🛍️ Flutter E-Commerce Mini App

A compact but complete **Flutter e-commerce application** built using modern tools and best practices. This project demonstrates key functionality required in a production-ready app, such as authentication, state management, offline support, persistent storage, and API integration.

---

## 🚀 Features

### 🔐 Authentication
- Firebase Email/Password login & registration
- Form validation & error handling
- Authentication state persistence

### 🛍️ Product Catalog
- Data fetched from [DummyJSON API](https://dummyjson.com/products)
- Infinite scroll (pagination)
- Product categories with filter
- Search functionality

### 📝 Product Details
- Product title, description, rating, images
- Display related products by category

### ❤️ Wishlist & Cart
- Add/remove items to/from cart or wishlist
- **Local persistence** using Hive
- UI badges with item count

### 📶 Offline Support
- Products are cached locally after fetching
- Cart and Wishlist persist without internet

### 🎨 Theming
- Light/Dark mode toggle
- Consistent **Purple & White gradient** design

### 🧭 Navigation
- Declarative routing with `go_router`
- Named routes for pages
- Redirect based on auth state

### 🧠 State Management
- `flutter_bloc` for Cubits and Blocs
- Separate states for Loading / Success / Error / Empty
- BlocBuilders and BlocListeners for reactive UI

---

## 📦 Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  bloc: ^9.0.0
  connectivity_plus: ^7.0.0
  dartz: ^0.10.1
  dio: ^5.9.0
  equatable: ^2.0.7
  firebase_auth: ^6.0.2
  firebase_core: ^4.1.0
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.1
  get: ^4.7.2
  get_it: ^8.2.0
  go_router: ^16.2.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  http: ^1.5.0
  intl: ^0.20.2
  js: ^0.7.2
  pull_to_refresh: ^2.0.0
  shared_preferences: ^2.5.3
