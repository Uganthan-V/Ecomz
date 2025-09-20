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

Below are the screenshots showcasing the **Light Mode** and **Dark Mode** of the Flutter E-Commerce Mini App. Images are paired by their respective numbers where possible, with each mode displayed in a separate container side by side. A placeholder icon is shown if an image is missing or fails to load.

| **Light Mode** | **Dark Mode** |
|----------------|---------------|
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light.jpeg" alt="Light Mode Main" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark.jpeg" alt="Dark Mode Main" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (1).jpeg" alt="Light Mode 1" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> | <div style="text-align: center;"> <img src="data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'" alt="No Dark Mode Image" width="300"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (2).jpeg" alt="Light Mode 2" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark (2).jpeg" alt="Dark Mode 2" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (3).jpeg" alt="Light Mode 3" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark (3).jpeg" alt="Dark Mode 3" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (4).jpeg" alt="Light Mode 4" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> | <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/dark (4).jpeg" alt="Dark Mode 4" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> |
| <div style="text-align: center;"> <img src="https://github.com/Uganthan-V/Ecomz/raw/main/assets/Preview/light (6).jpeg" alt="Light Mode 6" width="300" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'"/> </div> | <div style="text-align: center;"> <img src="data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22 viewBox=%220 0 300 400%22%3E%3Crect width=%22300%22 height=%22400%22 fill=%22%23ccc%22/%3E%3Cpath d=%22M120 80h60v40h40v60h-40v40h-60v-40h-40v-60h40v-40z%22 fill=%22%23fff%22/%3E%3Ctext x=%2250%22 y=%22350%22 fill=%22%23fff%22 font-size=%2220%22%3EImage Not Found%3C/text%3E%3C/svg%3E'" alt="No Dark Mode Image" width="300"/> </div> |

---

### 📝 Instructions to Clone the Repository

To get started with the Flutter E-Commerce Mini App, clone the repository using the following command:

```bash
git clone https://github.com/Uganthan-V/Ecomz.git