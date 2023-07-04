part of 'user_search_bloc.dart';

// Events
abstract class UserSearchEvent {}

class SearchTextChanged extends UserSearchEvent {
  final String searchText;
  final int paginatedBy;

  SearchTextChanged(this.searchText, this.paginatedBy);
}

// States

abstract class UserSearchState {}

class UserSearchInitial extends UserSearchState {}

class UserSearchLoading extends UserSearchState {}

class UserSearchLoaded extends UserSearchState {
  final List<DocumentSnapshot> searchResults;

  UserSearchLoaded(this.searchResults);
}

class UserSearchError extends UserSearchState {
  final String errorMessage;

  UserSearchError(this.errorMessage);
}
