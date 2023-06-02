import '../domain/entities/message_entity.dart';

List<String> countContacts(List<MessageEntity> messages) {
  List<String> contacts = [];

  messages.forEach((element) {
    if (contacts.contains(element.receiver)) {
    } else {

      contacts.add(element.receiver);
    }
  });

  return contacts;
}
