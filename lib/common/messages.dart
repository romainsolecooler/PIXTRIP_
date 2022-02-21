import 'package:get/route_manager.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': {
          'error_title': 'Erreur',
          'sucess_title': 'Succès !',
          'attention_title': 'Attention !',
          'yes': 'Oui',
          'no': 'Non',
          'copied_to_clipboard': 'Copié dans le presse papier.',
          'ok': 'Ok',
          'urban': 'Urbain',
          'country': 'Campagne',
          'monday': 'Lundi',
          'tuesday': 'Mardi',
          'wednesday': 'Mercredi',
          'thursday': 'Jeudi',
          'friday': 'Vendredi',
          'saturday': 'Samedi',
          'sunday': 'Dimanche',
          'closed': 'Fermé',
          'environment': 'Environnement',
          'category': 'Catégorie',
          'cultural': 'Culturel',
          'architectural': 'Architectural',
          'point_of_view': 'Point de vue',
          'artistic': 'Artistique',
          'flora_and_fauna': 'Faune et flore',
          'unusual': 'Insolite',
          'instagrammable': 'Instagrammable',
          'cgu': "Conditions générales d'utilisation",
          'privacy_policy': 'Politique de confidentialité',
          'bug_report': 'Signaler un bug',
          'show_tutorial': 'Afficher le tutoriel',
          'apply_filter': 'Appliquer ces filtres ?',
          'permissions__error':
              'Pixtrip a besoin des autorisations demandées précédemment pour pouvoir fonctionner.',
          'permissions__change_permissions': 'Changer les autorisations',
          'image_picker__title': 'Sélectionner depuis :',
          'image_picker__camera': 'Appareil photo',
          'image_picker__gallery': 'Gallerie',
          'oauth__error':
              'Utilisateur déjà existant ou créé via le formulaire.',
          'oauth_error__no_email':
              "Ce compte ne possède pas d'adresse mail.\nLa connexion est donc impossible.",
          'login__go_register': 'créer un compte',
          'login__pseudo_mail': 'pseudo / adresse email',
          'login__password': 'mot de passe',
          'login__stay_connected': 'rester connecté',
          'login__continue': 'continuer',
          'login__or_continue_with': 'ou continuer avec',
          'login__forgotten_password': 'mot de passe oublié ?',
          'login__error_empty':
              'Veuillez renseigner une adresse mail / pseudo et un mot de passe.',
          'login__failed':
              'Aucun utilisateur trouvé pour cette combinaison adresse email / pseudo et mot de passe.',
          'apple_sign_in__no_mail': "Aucun utilisateur trouvé.",
          'register__mail': 'adresse email',
          'register__pseudo': 'pseudo',
          'register__password': 'mot de passe',
          'register__accept_conditions': "accepter les conditions",
          'register__create_account': 'créer votre compte',
          'register__error_accept': 'Veuillez accepter les conditions.',
          'register__error_empty':
              'Veuillez remplir tous les champs du formulaire.',
          'register__error_mail': 'Veuillez renseigner une adresse mail.',
          'register__error_exist': 'Cet utilisateur existe déjà.',
          'forgot_password__title': 'Entrez votre adresse email',
          'forgot_password__placeholder': 'adresse email',
          'forgot_password__get_back_password': 'récupérer mon mot de passe',
          'forgot_password__error_text': 'Aucune adresse mail trouvée.',
          'forgot_password__sucess_text':
              "Un mail vient d'être envoyé à votre adresse mail. Merci de suivre les instructions.",
          'app__home': 'Home',
          'app__trip': 'Trip',
          'app__profil': 'Profil',
          'app__create_trip': 'Créer un trip',
          'app__wallet': 'Wallet',
          'home__or': 'Ou',
          'home__choose_trip_title': 'Je sélectionne mon trip',
          'home__choose_trip_text': 'Parmi tous les Trips du département !',
          'tutorial__next': 'SUIVANT',
          'tutorial__next_last': 'GO !',
          'tutorial__1_title': "Merci d'avoir téléchargé Pixtrip !",
          'tutorial__1_text':
              "Voici de quoi te guider afin de profiter à 100% de tes trips !",
          'tutorial__2_title': 'Choisis ton Trip !',
          'tutorial__2_text': "Des lieux à découvrir ou à faire découvrir !",
          'tutorial__3_title': 'Rends-toi dans la zone bleue !',
          'tutorial__3_text': "Pour commencer le trip !",
          'tutorial__4_title': 'Trouve le lieu !',
          'tutorial__4_text':
              "En suivant les indications de la boussole Pixtrip !",
          'tutorial__5_title': "Informe-toi !",
          'tutorial__5_text':
              "Prends le lieu en photo et découvre tout ce qu'il y a à savoir sur cet endroit !",
          'tutorial__6_title': "Gagne des récompenses !",
          'tutorial__6_text': "Et cumule-les en réalisant plus de trips !",
          'tutorial__7_title': "Deviens\n« pixtripeur » !",
          'tutorial__7_text':
              "Plusieurs trips t'attendent déjà ! Tu as la possibilité d'en créer, ils seront partagés !",
          'trips__or': 'Ou',
          'trips__city_name': "Nom d'une ville",
          'trips__no_trip_found': 'Aucun trip trouvé.',
          'trips__current_position': 'Ma position',
          'trips__validate': 'VALIDER',
          'trip__distance_calculation': 'calcul de la distance',
          'slider__distance_label': 'Distance : @distance km',
          'slider__distance_0': "Distance : à moins de 5 km",
          'slider__distance_1': "Distance : à moins de 10 km",
          'slider__distance_2': "Distance : à moins de 20 km",
          'slider__distance_3': "Distance : à moins de 50km",
          'slider__distance_4': "Distance : à 50km et plus",
          'slider__distance_5': "Distance : 5km",
          'slider__distance_6': "Distance : Plus de 5km",
          'slider__time_0': "Temps : Moins d'une heure",
          'slider__time_1': "Temps : Entre 1h et 2h",
          'slider__time_2': "Temps : Entre 2h et 3h",
          'slider__time_3': "Temps : Plus de 3h",
          'slider__difficulty_0': "Difficulté 1 : c'est cadeau !",
          'slider__difficulty_1':
              'Difficulté 2 : facile avec de la motivation !',
          'slider__difficulty_2': 'Difficulté 3 : ça se mérite !',
          'picker_cancel': 'retour',
          'picker_confirm': 'confirmer',
          'distance_picker__title': "Distance jusqu'au trip",
          'distance_picker__text': "distance jusqu'au trip",
          'distance_picker_0': '- de 5km',
          'distance_picker_1': '- de 10km',
          'distance_picker_2': '- de 20km',
          'distance_picker_3': '- de 50km',
          'distance_picker_4': '+ de 50km',
          'difficulty_picker__title': 'Difficulté',
          'difficulty_picker__text': 'difficulté',
          'difficulty_picker__0': "c'est cadeau !",
          'difficulty_picker__1': "facile avec de la motivation !",
          'difficulty_picker__2': "ça se mérite !",
          'category_picker__title': 'Catégorie',
          'category_picker__text': 'catégorie',
          'trips__go': 'GO !',
          'distance_until_trip': "Distance jusqu'au trip :",
          'distance_less_than_50': 'Moins de 50 mètres',
          'profil__error_change_image':
              'Erreur lors du changement de votre photo de profil. Veuillez essayer avec une autre image.',
          'profil__empty_list': "Tu n'as terminé aucun trip.",
          'profil__age_placeholder': 'Age',
          'profil__validate_changes': 'VALIDER',
          'profil__old_password': 'Ancien mot de passe',
          'profil__new_password': 'Nouveau mot de passe',
          'profil__changed_success_title': 'Succès !',
          'profil__changed_success_text': 'Profil modifié.',
          'profil__changed_password_title': 'Succès !',
          'profil__changed_password_text': 'Mot de passe modifié avec succès.',
          'profil__changed_error': 'Combinaison email / pseudo déjà utilisée.',
          'profil__logout_text': 'Veux-tu vraiment te déconnecter ?',
          'change_profil__invalid_age': 'Merci de renseigner un âge valide.',
          'change_profil__empty':
              'Merci de renseigner une adresse email et un pseudo.',
          'change_profil__invalid_email':
              'Merci de renseigner une adresse email valide.',
          'change_profil__error':
              'Combinaison adresse email / pseudo déjà utilisée.',
          'change_password__error_empty':
              'Merci de renseigner votre ancien et un nouveau mot de passe.',
          'change_password__error_same':
              "L'ancien mot de passe et le nouveau ne peuvent pas être identiques.",
          'change_password__error_wrong': 'Ancien mot de passe incorrect.',
          'change_password__success_text': 'Mot de passe modifié.',
          'add_trip__add_photo': 'AJOUTER UNE PHOTO',
          'add_trip__add_city_placeholder': 'Nom de la ville',
          'add_trip__add_position_placeholder': 'Position',
          'add_trip__add_first_info_placeholder': 'Info principale',
          'add_trip__add_second_info_placeholder': 'Anecdote',
          'add_trip__add_third_info_placeholder': 'Ma vision sur ce lieu',
          'add_trip_add_button': 'VALIDER',
          'add_trip__empty_form':
              'Veuillez remplir tous les champs du formulaire.',
          'add_trip__error_text': "Erreur lors de l'ajout du trip.",
          'add_trip__sucess':
              "Votre trip va être soumis à validation par l'équipe de Pixtrip.\nIl sera bientôt disponible.",
          'wallet__empty': 'Tu ne possèdes aucun coupon.',
          'add_trip__fail':
              "Une erreur est survenue lors de l'ajout de votre trip.",
          'wallet__page_separator': 'Déjà utilisé',
          'wallet__empty_unused_coupons': "Tu n'as aucun coupon à utiliser.",
          'wallet__empty_used_coupons': "Tu n'as utilisé aucun coupon.",
          'coupon_details__info_position': 'Info et Position',
          'coupon_details_code': 'Code du coupon : @code',
          'merchant_infos__name': 'Nom :',
          'merchant_infos__address': 'Adresse :',
          'merchant_infos__phone': 'Téléphone :',
          'merchant_infos__open_at': 'Ouvert :',
          'merchant_infos__link': 'Lien :',
          'travel__give_up_trip': 'abandonner le trip',
          'travel__take_photo': 'prendre une photo',
          'travel__popup_give_up_trip_title':
              'Es-tu sûr de vouloir abandonner ton trip ?',
          'travel__popup_give_up_trip_button': 'ABANDONNER',
          'travel__get_in_zone':
              'Rentre dans la zone pour commencer ton trip !',
          'travel__compass_text': 'Prends en photo pour terminer le Trip !',
          'travel__sucess_title': 'Bravo !',
          'travel__sucess_text': 'Tu es au bon endroit !',
          'travel__fail_title': 'Le lieu ne correspond pas...',
          'travel__fail_text': 'Mais continue, tu y es presque !',
          'travel__fail_continue_trip': 'POURSUIVRE LE TRIP',
          'trip_details__steps': 'Nombre de pas',
          'trip_details__traveled_distance': 'Distance parcourue',
          'trip_details__travel_realised': 'Parcours réalisé',
          'trip_details__choose_coupon': 'Choisis ta récompense !',
          'trip_details__select_coupon_title': 'Attention !',
          'trip_details__select_coupon_text':
              'Es tu sûr de vouloir sélectionner cette promotion ?',
          'trip_details__select_confirm': 'Oui',
          'trip_details__select_cancel': 'Non',
          'trip_details__added_coupon_text':
              'Ce coupon a bien été ajouté à ton Wallet !',
          'trip_details__added_coupon_error':
              "Tu possède déjà ce coupon.\n\nUtilise le pour le sélectionner à nouveau.",
          'trip_details__share_title': 'Partager sur :',
          'trip_details__share_message':
              "Hey ! Regarde !\nJ'ai fait un trip à @name, j'ai effectué @distance en @steps pas !\nTu penses pouvoir faire mieux ? Rejoins-moi sur Pixtrip !",
          'measure__meters': '@distance mètres',
          'measure__kilometers': '@distance km',
        },
      };
}
