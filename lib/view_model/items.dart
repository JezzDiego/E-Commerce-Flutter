import 'package:araplantas_mobile/enums.dart';
import 'package:araplantas_mobile/models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ItemViewModel {
  CollectionReference<Map<String, dynamic>> itemsCollection =
      FirebaseFirestore.instance.collection(Collections.items.name);

  CollectionReference<Map<String, dynamic>> usersCollection =
      FirebaseFirestore.instance.collection(Collections.users.name);

  Stream<List<Item>> getUserSavedItems(String id) {
    return usersCollection
        .doc(id)
        .collection(Collections.savedItems.name)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());
  }

  String _responseMessage = "";
  String get responseMessage => _responseMessage;

  String _responseError = "";
  String get responseError => _responseError;

  Stream<List<Item>> getItems() {
    return itemsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());
  }

  Future saveItem(Item item, String userId) async {
    try {
      await usersCollection
          .doc(userId)
          .collection(Collections.savedItems.name)
          .doc(item.id)
          .set(item.toJson());
    } on FirebaseException catch (e) {
      _responseError = e.toString();
      _responseMessage = "Item salvo com sucesso!";
    } catch (e) {
      _responseError = e.toString();
      _responseMessage = "Erro ao salvar item!";
    }
  }

  Future removeSavedItem(String itemId, String userId) async {
    try {
      await usersCollection
          .doc(userId)
          .collection(Collections.savedItems.name)
          .doc(itemId)
          .delete();
      print(itemId);
    } on FirebaseException catch (e) {
      print("erro");
      _responseError = e.toString();
      _responseMessage = "Item removido dos itens salvos!";
    } catch (e) {
      print("erro 2");
      _responseError = e.toString();
      _responseMessage = "Erro ao remover item dos itens salvos!";
    }
  }
}
