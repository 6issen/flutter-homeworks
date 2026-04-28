# План релиза: day_42_release

## 1. Чек-лист подготовки
- [x] Обновлен `versionName` (1.0.1) и `versionCode` (2) в `pubspec.yaml`.
- [x] Настроены иконки через `flutter_launcher_icons`.
- [x] Настроен Splash Screen через `flutter_native_splash`.
- [x] Добавлены разрешения в `AndroidManifest.xml` (Camera, Storage, Notifications).
- [ ] Сгенерирован Keystore: `keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`.
- [ ] Настроен `key.properties` и `build.gradle` для подписи.

## 2. Список «Релизные риски и баги»
1. **Permission Denied**: Пользователь может отклонить доступ к камере. Нужно корректно обрабатывать `permission_handler`.
2. **Splash Screen Lag**: На старых устройствах Android (ниже 12) сплэш может отображаться некорректно без настройки `styles.xml`.
3. **App Size**: Проверить размер `.aab` файла. Если слишком большой — оптимизировать ассеты.
4. **API Compatibility**: Минимум SDK установлен на 21. Проверить на Android 5.0.

## 3. План отката (Rollback Plan)
1. **В Google Play**: Если критический баг обнаружен после выкладки в Internal Testing, немедленно приостановить распространение релиза.
2. **Версионирование**: Создать Hotfix-ветку, исправить баг, инкрементировать `versionCode` (например, до 3) и залить новый билд.
3. **Локально**: Всегда держать тег в Git для предыдущей стабильной версии (например, `v1.0.0`), чтобы иметь возможность быстро пересобрать старый билд.

## 4. Permissions Policy (Privacy)
- **Camera**: Используется для профильного фото пользователя.
- **Notifications**: Для отправки напоминаний о задачах.
- **Storage**: Для сохранения отчетов.
