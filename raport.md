## Raport z Wykonania Projektu Portal ogłoszeniowy z systemem ocen i recenzji.

## Cel Projektu
DealHub to aplikacja internetowa, która pozwala użytkownikom publikować oferty dotyczące produktów i usług oraz daje możliwosc oceniania i recenzowania tych ofert.

## Opis Projektu
- Nazwa projektu: DealHub
- Autorzy: Adrian Ciołek, Mateusz Cyran, Kamil Duszyński, Nikodem Decewicz, Dawid Dymek
- Repozytorium: [DealHub](https://github.com/Qwizi/DealHub/)
- Licencja: MIT

## Technologie
- Python 3.10+
- Django
- Django Allauth
- Docker
- PostgresSQL
- HTMX
- DaisyUI

## Funkcjonalności
- Rejestracja i logowanie użytkowników.
- Dodawanie oraz wyświetlanie ofert.
- Ocena i recenzja ofert.
- Prowizoryczne "kupowanie" danego przedmotu z oferty.
- **Łatwa instalacja aplikacji** wystarczy jedna komenda w terminalu aby uruchomic caly projekt :)

## Realizacja
Projekt został zrealizowany z wykorzystaniem frameworka Django. 
Użyliśmy również biblioteki django Allauth do szybiej i prostej autoryzacji użytkownikow (logowanie/rejestracja).
Do stworzenia interfejsu użytkownika użyliśmy HTMX oraz DaisyUI.
Do przechowywania danych użyliśmy bazy danych PostgresSQL.
Aplikacja została podzielona na moduły, które odpowiadają za konkretne funkcjonalności. Wszystkie moduły są ze sobą połączone i współpracują ze sobą. 
Aplikacja została zaprojektowana w taki sposób, aby była łatwa w rozbudowie i modyfikacji oraz utworzony został skrypt instalacyjny w bashu, który pozwala na uruchomienie aplikacji w jednej komendzie.
Zastosowalismy również bardzo przydatne github actions, które np. aktualizuja automatycznie wersja aplikacji, tworzą nowe release'y oraz buduja obraz dockera i wrzucaja go na dockerhub.

## Napotkane Problemy
- Problemy z instalacja poetry na windowsie.
- Wiekszość z nas pierwszy raz korzystała z wyżej wymienionych technologii.
- Troche problemow z deployem na serwer gdzie znajduje sie instancja coolify.

## Propozycje Rozwoju
- Zaimplementowanie płatności.
- Dodanie możliwości komentowania recenzji.
- Dodanie możliwości dodawania zdjęć do ofert zamiast linków.
- Dodanie możliwości dodawania ofert do ulubionych.
- Dodanie możliwości edycji ofert.
- Wyswietlanie zakupionych ofert w panelu użytkownika.
- Stworzenie panelu użytkownika mozliwoscia podgladu hisotrii zakupow oraz dodawania ofert.
- Doddanie proponowanych ofert na podstawie ocen i recenzji.
- Napisanie testów jednostkowych oraz integracyjnych.

## Źródła
- [Django docs](https://docs.djangoproject.com/en/5.0/)
- [Django Allauth docs](https://docs.allauth.org/en/latest/)
- [DaizyUI docs](https://daisyui.com/docs/install/)
- [HTMX docs](https://htmx.org/docs/)
- [TailwindCSS docs](https://tailwindcss.com/docs/installation)
- Proste poradniki zrobione dla reszty czlonkow zespolu
  - [Poradnik 1](https://youtu.be/GZgwMlA5QOI)
  - [Poradnik 2](https://youtu.be/1NXbbKsPF7A)
- Oczywiscie stackoverflow oraz github copilot :)