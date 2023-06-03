# Flashspeak
<img src="FlashSpeak/FlashSpeak/Resources/Assets.xcassets/AppIcon.appiconset/256.png" width="128">
Приложение iOS для изучения иностранных слов по наборам карточек.

## Содержание
- [Обзор](#обзор)
    - [Возможности](#возможности)
       - [Выбор языка изучения](#выбор-языка-изучения)
       - [Создание и редактирование списка слов](#создание-и-редактирование-списка-слов)
       - [Создание карточки](#создание-карточки)
       - [Просмотр карточек](#просмотр-карточек)
       - [Редактирование карточки](#редактирование-карточки)
       - [Изучение](#изучение)
       - [Просмотр результатов изучения](#просмотр-результатов-изучения)
       - [Темы приложения](#темы-приложения)
    - [Реализация](#реализация)
       - [Архитектура](#архитектура)
       - [Паттерны](#паттерны)
       - [Библиотеки](#библиотеки)
       - [Хранение данных](#хранение-данных)
       - [Требования](#требования)
- [Как запустить](#как-запустить)
- [Зачем](#зачем)
- [To Do](#to-do)
- [Команда проекта](#команда-проекта)

## Обзор

### Возможности
Пользователь, [выбрав язык изучения](#выбор-языка-изучения), может легко [создать свой список слов](#создание-и-редактирование-списка-слов). Слова можно добавить через вставку или вводя по отдельности. [Приложение сформирует перевод и найдет подходящие изображения](#создание-карточки) для каждого слова. Пользователь может [просмотреть получившиеся карточки](#просмотр-карточек), а если перевод и подобранное изображение не подойдут то [можно загрузить свое изображение или изменить перевод слова](#редактирование-карточки). [Изучение можно проходить по различным сценариям](#изучение). Карточку для изучения можно сделать из частей: исходное слово, перевод и изображение. Отвечать на предложенную карточку можно через тестирование или набирая ответ на клавиатуре. Для понимания звучания, есть кнопка произнести слово вслух. Результаты прохождения каждого изучения списка сохранаются и [формируются в статистику](#просмотр-результатов-изучения), так же пользователю будут показаны ошибки для работы над ошибками. Приложение поддерживает [темную и светлую тему](#темы-приложения) отображения.

#### Выбор языка изучения
Экран Welcome...

#### Создание и редактирование списка слов
Экран ListMaker...

#### Создание карточки
APIs...

#### Просмотр карточек
Экран WordCards...

#### Редактирование карточки
Экран Card...

#### Изучение
Экран Learn...

#### Просмотр результатов изучения
Экран Result...

#### Темы приложения
- Светлая
- Темная

## Реализация

### Архитектура
 - ModelViewPresenter

### Паттерны
 - Delegate
 - Strategy
 - Caretaker
 - Singleton
 - Coordinator
 - Router
 - Builder

### Библиотеки
- UIKit
- CoreData
- Combine
- AVFoundation 

### Хранение данных
- CoreData
- UserDefaults
- Config.xcconfig

### Требования
- iOS 16.0+
- Xcode 14.3

## Как запустить
- Настройте Config.xcconfig...

## Зачем
Проект создан в рамках курса "Командная разработка на Swift" в школе [GeekBrains](https://gb.ru).
[@DenDmitriev] (https://www.github.com/DenDmitriev)

## To Do
- [ ] Добавить трансфер списка слов на другой язык
- [ ] Сделать экран настроек приложения
- [ ] Сделать несколько списков слов по умолчанию при первом открытии приложения
- [ ] Добавить возможность сменить язык в приложении

## Команда проекта
- [DenDmitriev](https://github.com/DenDmitriev)
- [losikova](https://github.com/losikova)
- [OksanaKam](https://github.com/OksanaKam)
- [Heoh888](https://github.com/Heoh888)
