import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_todo/model/model.dart';
import 'package:redux_todo/redux/actions.dart';
import 'package:redux_todo/redux/middleware.dart';
import 'package:redux_todo/redux/reducres.dart';
import 'package:redux_todo/widgets/add_item.dart';
import 'package:redux_todo/widgets/list_item.dart';
import 'package:redux_todo/widgets/remove_items.dart';

void main() {
  final Store<AppState> store = Store<AppState>(appStateReducer,
      initialState: AppState.initialState(), middleware: appStateMiddleware());

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.redAccent),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (context, Store<AppState> store) {
            return MyHomePage(title: 'Redux Todo', store: store);
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.store}) : super(key: key);
  final String title;
  final Store<AppState> store;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (context, ViewModel viewModel) {
          return Column(
            children: <Widget>[
              AddItemWidget(viewModel),
              Expanded(
                child: ItemListWidget(viewModel),
              ),
              RemoveItemsWidget(viewModel),
            ],
          );
        },
      ),
    );
  }
}

class ViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;
  final Function(Item) onCompleted;

  ViewModel(
      {this.items,
      this.onAddItem,
      this.onRemoveItem,
      this.onRemoveItems,
      this.onCompleted});

  factory ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) {
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    _onCompleted(Item item) {
      store.dispatch(ItemCompletedAction(item));
    }

    return ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
      onCompleted: _onCompleted,
    );
  }
}
