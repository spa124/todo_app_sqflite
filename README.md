## To-Do List App

### How to Run

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Use `flutter run` to start the app on an emulator or physical device.

### Features

Create, edit, and delete to-do items.
Persist data locally using SQLite.
Manage state with MVVM architecture.
Clean and maintainable code structure.

### Project Structure

The app follows the MVVM (Model-View-ViewModel) architecture.

lib/
├── main.dart                
├── models/                  
│   └── todo_item.dart       
├── views/                   
│   ├── home_screen.dart     
│   ├── add_edit_screen.dart
│   └── detail_screen.dart   
├── viewmodels/              
│   └── todo_view_model.dart 
├── repositories/            
│   └── todo_repository.dart 
└── services/                
   └── db_helper.dart      


