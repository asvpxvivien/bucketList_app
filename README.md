
# 🎯 BucketList App

A modern and intuitive Flutter app to manage your bucket list. Users can add goals with images and estimated costs, view details, and mark them as completed. Data is stored in Firebase Realtime Database, and HTTP requests are handled using the Dio package.

##  Features

- Add new bucket list items (title, cost, image URL)
- View all non-completed items
- Mark an item as completed
- Delete an item
- Animated transitions and responsive UI
- Firebase Realtime Database integration
- HTTP requests via Dio


## 🎞 Demo GIF 
<p align="center">
  <img src="assets/bucket_list_app.gif" alt="Demo" width="400"/>
</p>

##  Project Structure

```
lib/
├── main.dart                # Entry point of the app
├── screens/
│   ├── main_screen.dart     # Displays the list of items
│   ├── add_screen.dart      # Form to add a new item
│   └── view_screen.dart     # View, delete or mark item as completed
```

##  Dependencies

Make sure you have these in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
```

##  Firebase Configuration

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Enable Firebase Realtime Database.
3. Get your database URL (something like `https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/`).
4. Update all Dio request URLs with your Firebase database link.

##  How it Works

- Data is retrieved via GET request to Firebase.
- New items are added with PATCH to an indexed key.
- Items can be deleted or marked as completed via DELETE and PATCH respectively.
- App refreshes automatically after actions.



## ⚙️ Launch the project

1. Clone the repo :
```bash
git clone https://github.com/asvpxvivien/bucketList_app.git

2. Install the packages :
```bash
flutter pub get
```

3. Lunch the application:
```bash
flutter run
```






