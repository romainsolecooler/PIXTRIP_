import 'package:get/route_manager.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': {
          'app__home': 'Home',
          'app__trip': 'Trip',
          'app__profil': 'Profil',
          'app__create_trip': 'Créer un trip',
          'app__wallet': 'Wallet',
          'home__or': 'Ou',
          'home__choose_trip_title': 'Je choisis mon Trip',
          'home__choose_trip_text': 'Parmi tous les Trips du département !',
          'trips__or': 'Ou',
          'trips__city_name': "Nom d'une ville",
          'trips__current_position': 'Ma position',
          'trips__validate': 'VALIDER',
          'slider__distance_label': 'Distance : @distance km',
          'slider__time_0': "Temps : Moins d'une heure",
          'slider__time_1': "Temps : Entre 1h et 2h",
          'slider__time_2': "Temps : Entre 2h et 3h",
          'slider__time_3': "Temps : Plus de 3h",
          'slider__difficulty_0': 'Difficulté : Très facile',
          'slider__difficulty_1': 'Difficulté : Facile',
          'slider__difficulty_2': 'Difficulté : Ok avec de la motivation',
          'slider__difficulty_3': 'Difficulté : Difficile',
          'slider__difficulty_4': 'Difficulté : Dur',
          'slider__difficulty_5': 'Difficulté : Très dur',
          'trips__go': 'GO !',
          'add_trip__add_photo': 'AJOUTER UNE PHOTO',
          'add_trip__add_city_placeholder': 'Nom de la ville',
          'add_trip__add_position_placeholder': 'Position',
          'add_trip__add_first_info_placeholder': 'Info principale',
          'add_trip__add_second_info_placeholder': 'Anecdote',
          'add_trip__add_third_info_placeholder': 'Votre avis',
        },
      };
}
