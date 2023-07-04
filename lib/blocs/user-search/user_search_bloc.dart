import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

part 'user_search_events_and_states.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc() : super(UserSearchInitial()) {
    on<SearchTextChanged>((event, emit) async {
      emit(UserSearchLoading());
      try {
        final searchResults = await FirebaseFirestore.instance
            .collection('Users')
            .where('fullName', isGreaterThanOrEqualTo: event.searchText)
            .where('fullName', isLessThan: '${event.searchText}z')
            .get();
        emit(UserSearchLoaded(searchResults.docs.pickSome(event.paginatedBy)));
      } catch (e) {
        emit(UserSearchError("Something went wrong"));
      }
    });
  }
}
