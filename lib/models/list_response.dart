class ListResponse<T> {
  int count;
  List<T> result;

  ListResponse({ required this.count, required this.result });
}