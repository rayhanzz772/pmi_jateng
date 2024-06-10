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
    List<String> items = [
      "RSJ Diponegoro:Jawa Tengah:Semarang:assets/images/rs_diponegoro.png:Jl. Sriwijaya No.1, Pedurungan Kidul, Pedurungan, Kota Semarang, Jawa Tengah 50193:4.5:Telepon (024) 6713473",
      "RSJ Padjajaran:Jawa Tengah:Magelang:assets/images/rs_banyumanik.png:Jl. Tidar No.121, Rejomulyo, Magelang Tengah, Kota Magelang, Jawa Tengah 56116:4.0:Telepon (021) 3489134",
      "RSJ Banyumanik:Jawa Tengah:Semarang:assets/images/rs_magelang.png:Jl. Puri Anjasmoro Blok B No. 10, Kalitirto, Kabupaten Semarang, Jawa Tengah 57463:4.2:Telepon (024) 4354313",
    ];

    List<String> filteredItems = [];

    for (String item in items) {
      List<String> parts = item.split(':');
      if (parts.length == 7 && parts[1] == province && parts[2] == city) {
        String formattedItem =
            '${parts[0]}:${parts[1]}:${parts[2]}:${parts[3]}:${parts[4]}:${parts[5]}:${parts[6]}';
        filteredItems.add(formattedItem);
      }
    }

    return filteredItems;
  }
}
