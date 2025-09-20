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

## 📸 Previews

Below are the screenshots showcasing the **Light Mode** and **Dark Mode** of the Flutter E-Commerce Mini App. Images are paired by their respective numbers where possible, with each mode displayed in a separate container side by side.

| **Light Mode** | **Dark Mode** |
|----------------|---------------|
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light.jpeg" alt="Light Mode Main" width="300"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark.jpeg" alt="Dark Mode Main" width="300"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (1).jpeg" alt="Light Mode 1" width="300"/> </div> | <div style="text-align: center;"> No corresponding dark mode image </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (2).jpeg" alt="Light Mode 2" width="300"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark (2).jpeg" alt="Dark Mode 2" width="300"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (3).jpeg" alt="Light Mode 3" width="300"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark (3).jpeg" alt="Dark Mode 3" width="300"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (4).jpeg" alt="Light Mode 4" width="300"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark (4).jpeg" alt="Dark Mode 4" width="300"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (6).jpeg" alt="Light Mode 6" width="300"/> </div> | <div style="text-align: center;"> No corresponding dark mode image </div> |

---

### 📝 Instructions to Clone the Repository

To get started with the Flutter E-Commerce Mini App, clone the repository using the following command:

```bash
git clone https://github.com/Uganthan-V/Ecomz.git