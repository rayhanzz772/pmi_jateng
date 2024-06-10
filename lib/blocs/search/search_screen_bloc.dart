// search_screen_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent();

  @override
  List<Object> get props => [];
}

class SearchItems extends SearchScreenEvent {
  final String province;
  final String city;

  const SearchItems({required this.province, required this.city});

  @override
  List<Object> get props => [province, city];
}

// search_screen_state.dart

abstract class SearchScreenState extends Equatable {
  const SearchScreenState();

  @override
  List<Object> get props => [];
}

class SearchScreenInitial extends SearchScreenState {}

class SearchScreenLoading extends SearchScreenState {}

class SearchScreenLoaded extends SearchScreenState {
  final List<String> items; // Example: List of items

  const SearchScreenLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class SearchScreenError extends SearchScreenState {
  final String error;

  const SearchScreenError(this.error);

  @override
  List<Object> get props => [error];
}

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc() : super(SearchScreenInitial()) {
    on<SearchItems>(_onSearchItems);
  }

  Future<void> _onSearchItems(
    SearchItems event,
    Emitter<SearchScreenState> emit,
  ) async {
    emit(SearchScreenLoading());
    try {
      // Simulate fetching items based on province and city
      await Future.delayed(Duration(seconds: 2));
      List<String> items =
          _fetchItemsByProvinceAndCity(event.province, event.city);
      emit(SearchScreenLoaded(items));
    } catch (e) {
      emit(SearchScreenError("Failed to load items"));
    }
  }

  List<String> _fetchItemsByProvinceAndCity(String province, String city) {
    // Example logic to filter items based on province and city
    // Replace this with your actual data fetching logic
    List<String> items = [
      "Rumah Sakit Diponegoro:Jawa Tengah:Semarang:assets/images/rs_diponegoro.png",
      "Rumah Sakit Magelang:Jawa Tengah:Magelang:assets/images/rs_magelang.png",
      "Rumah Sakit Banyumanik:Jawa Tengah:Semarang:assets/images/rs_banyumanik.png",
    ];
    List<String> filteredItems = [];

    for (String item in items) {
      List<String> parts = item.split(':');
      if (parts.length == 4 && parts[1] == province && parts[2] == city) {
        // Create an object to represent each item
        String hospitalName = parts[0];
        String province = parts[1];
        String city = parts[2];
        String imagePath = parts[3];

        // Add item information to the list
        String formattedItem = '$hospitalName:$province:$city:$imagePath';
        filteredItems.add(formattedItem);
      }
    }

    return filteredItems;
  }
}
