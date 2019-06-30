# redux_todo 📋

A flutter todo app with `redux` and `shared_prefs` (for saving using middleware)

``` dart
List<Middleware<AppState>> appStateMiddleware([AppState state = const AppState(items: <Item>[])]) {
  final loadItems = _loadFromPrefs(state);
  final saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
  ];
}
```
