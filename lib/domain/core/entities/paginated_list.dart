class PaginatedList<T> {
  final int totalRecords;
  final List<T> data;

  PaginatedList(this.totalRecords, this.data);
}
