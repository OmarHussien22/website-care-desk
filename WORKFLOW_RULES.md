# AI_RULES.md — `mobile_base` / Coursaty Flutter Project

> **Single source of truth for all AI agents.**
> Antigravity, OpenCode, Claude, and Copilot all read this file.
> Do NOT duplicate rules elsewhere — just reference this file.
>
> **Principles:** Non-negotiable project principles live in
> `.specify/memory/constitution.md` and are authoritative for all work
> (not only speckit commands). When in doubt, the constitution wins.

---

## 1. Project Identity

| Key | Value |
|---|---|
| App name | `coursaty` |
| Package | `package:coursaty/…` |
| SDK | Dart ^3.11.1 |
| State management | **GetX** (`get: ^4.7.3`) |
| Navigation | **GetX named routes** via `AppRoutes` constants |
| HTTP client | **Dio** via `ServicesInterface → RepoInterface → UseCase` |
| Storage | `StorageService<T>` (get_storage + shared_preferences) |
| UI scaling | `flutter_screenutil` — `.toW()` `.toH()` `.toFS()` `.ESH()` `.ESW()` `.toRad()` |
| Fonts | Custom `URW` + `Montserrat` (bundled — do NOT add google_fonts) |
| Error monitoring | Sentry (activate in production) |
| App mode | `AppSettings.appMode`: `AppMode.prod / .dev / .test` |

---

## 2. Hard Rules (Zero Exceptions)

1. **GetX only** for state — no Riverpod, Bloc, Provider, ChangeNotifier
2. **GetX named routes only** — no go_router, no direct Navigator push/pop
3. **No `print()`** — use `log('msg', name: 'ClassName')` from `dart:developer`, or `printDM()`
4. **No `!` on untrusted nullables** — use `?.`, `?? fallback`, or `if (x != null)`
5. **No raw pixel values** — always use screenutil helpers (`.toW()`, `.ESH()`, etc.)
6. **No hardcoded colors** — always `AppColors.get.*`
7. **No raw `Text()`** in pages — always `CustomText(…)`
8. **Dispose every `TextEditingController`** in `onClose()` of its GetX controller
9. **No `try-catch` around `useCase()` calls** — the pipeline returns `DataFailed` for all errors

---

## 3. File & Naming Conventions

| Element | Convention | Example |
|---|---|---|
| Classes / Enums | `PascalCase` | `LoginController` |
| Files | `snake_case.dart` | `login_controller.dart` |
| Variables / methods | `camelCase` | `isButtonDisabled` |
| Private members | `_camelCase` | `_checkButtonState` |
| Route constants | `static const lowerCamel` | `AppRoutes.forgotPassword` |
| API URL fields | `uRL` prefix | `uRLLogin`, `uRLRegister` |
| Singletons | `ClassName._()` + `static final instance` | `LoginApiService._()` |

---

## 4. Architecture — Feature-First Clean Architecture

Auth is the **canonical example** — replicate exactly for every new feature.

```
lib/
  main.dart                      ← entry: AppInitializer.initializeApp() → runApp(MyApp())
  packages_index.dart            ← barrel re-exports (GetX, ScreenUtil, Equatable…)
  src/
    my_app.dart                  ← MyApp (StatefulWidget + WidgetsBindingObserver)
    core/
      app/                       ← AppSettings, AppInitializer, AppMaterial
      constants/                 ← AppInsets, AppSizes, AppImages, AppIcons, AppLottie
      network_structure/         ← Full HTTP pipeline (see §5)
      routers/                   ← AppRouter (GetPage list), AppRoutes, RouteArgs
      services/                  ← DeviceInfo, Lang, Storage, Firebase, Sentry, etc.
      styles/                    ← AppColors (LightColor/DarkColor), Themes
      utils/                     ← Extensions, Validators, SnackUtils
    features/
      <feature>/
        core/params/             ← Params objects (extend Params)
        data/data_sources/       ← *ApiService extends ServicesInterface
        domain/
          entities/
          repos/                 ← *Repository extends RepoInterface<T>
          use_cases/             ← *UseCase extends UseCase<T, P>
        presentation/
          controllers/           ← *Controller extends GetControllerInterface<T>
          pages/
          widgets/sheets/
    shared/                      ← Cross-feature entities, widgets, controllers
    super/                       ← Abstract base classes (UseCase, GetControllerInterface)
```

### New-feature checklist
- [ ] `Params` class in `features/<name>/core/params/`
- [ ] `*ApiService` with URL from `ApiNames` mixin
- [ ] `*Repository` with `onParse`, `testData`, `serviceInstance`
- [ ] `*UseCase` delegating to `Repository.instance.call(params:)`
- [ ] `*Controller` extending `GetControllerInterface<T>`
- [ ] Route constant in `AppRoutes`
- [ ] `GetPage` registered in `AppRouter.pages`

---

## 5. Network Pipeline

```
Controller → UseCase → Repository → ApiService → ServicesInterface → Dio (NetworkService)
```

Result is always `DataState<T>`: `DataSuccess<T>` or `DataFailed(ErrorModel)`.

### ApiService template
```dart
class LoginApiService extends ServicesInterface {
  LoginApiService._();
  static final instance = LoginApiService._();

  @override
  Future<Response> applyService({Params? params}) {
    return super.call(
      uRLLogin,            // from ApiNames mixin
      type: CrudType.post, // or CrudType.get
      params: params,
      showLoadingDialog: true,
    );
  }
}
```

### Repository template
```dart
class LoginRepository extends RepoInterface<UserEntity> {
  LoginRepository._();
  static final instance = LoginRepository._();

  @override
  ServicesInterface get serviceInstance => LoginApiService.instance;

  @override
  UserEntity Function(dynamic) get onParse => (data) => UserModel.fromJson(data);

  @override
  UserEntity? get testData => UserEntity.examples.first;
}
```

**Override these getters when needed:**
- `dataTitle` (default `'data'`) — JSON key wrapping the payload
- `responseType` → `ResponseType.withoutData` if no body expected
- `requireStatus` → `false` to skip `status` field check
- `withPagination` flag on the `ApiService.call(…)` for paginated endpoints

### UseCase template
```dart
class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  @override
  Future<DataState<UserEntity>>? call({LoginParams? params}) =>
      LoginRepository.instance.call(params: params);
}
```

### Adding a new API endpoint
1. Add URL to `ApiNames` mixin in `core/network_structure/api_names.dart`
2. Create `*ApiService`, `*Repository`, `*UseCase`, `*Params`

---

## 6. Controller Pattern

```dart
class FooController extends GetControllerInterface<FooEntity> {
  late TextEditingController inputController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool _isDisabled = true;
  bool get isDisabled => _isDisabled;

  @override
  void onInit() {
    super.onInit();
    inputController = TextEditingController();
    inputController.addListener(_checkState);
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }

  Future<void> doAction() async {
    formValidator(
      globalKey: globalKey,
      onSuccessValidate: () async {
        state = await FooUseCase()(params: FooParams(value: inputController.text))!;
        if (state is DataSuccess) {
          Get.offAllNamed(AppRoutes.home);
        } else if (state is DataFailed) {
          ClientSnacks.appStyledSnack(title: state.error!.title, state: UtilState.error);
        }
      },
    );
  }

  void _checkState() {
    _isDisabled = inputController.text.isEmpty;
    update();
  }
}
```

---

## 7. GetBuilder Performance

Avoid rebuilding full pages.

Prefer isolated rebuilds:

```dart
GetBuilder<FooController>(
  id: 'submitButton',
  builder: (_) => ButtonDefault(
    onPressed: controller.doAction,
  ),
)

----

## 8. Page Pattern

```dart
class FooPage extends GetView<FooController> {
  const FooPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FooController>(
      init: FooController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.get.white,
        body: SafeArea(
          child: Form(
            key: controller.globalKey,
            child: Column(children: [
              AppbarBackground(title: 'foo_title'.toTr(), showBackButton: true),
              // fields …
              GetBuilder<FooController>(    // isolated rebuild for button
                builder: (_) => ButtonDefault(
                  title: 'submit'.toTr(),
                  onPressed: controller.doAction,
                  isDisabled: controller.isDisabled,
                  backgroundColor: AppColors.get.primary,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
```

---

## 9. Routing

```dart
// Navigate forward
Get.toNamed(AppRoutes.forgotPassword);

// Navigate and replace stack
Get.offNamed(AppRoutes.resetPassword);
Get.offAllNamed(AppRoutes.login);

// With arguments
Get.toNamed(AppRoutes.verifyCode, arguments: VerifyCodeArgs(phone: '…', viewPhone: true));
final args = Get.arguments as VerifyCodeArgs;  // receive in page
```

---

## 10. Cross-Screen Transient State

Use a singleton builder (like `PhoneDataBuilder`) for data that must survive multiple navigations:
```dart
class PhoneDataBuilder {
  PhoneDataBuilder._();
  static PhoneDataBuilder instance = PhoneDataBuilder._();
  String phone = "";
  String countryCode = "";
  bool forRestPassword = false;

  void handleVerificationRoute() {
    if (forRestPassword) Get.offNamed(AppRoutes.resetPassword);
    else Get.offAllNamed(AppRoutes.setEducationInfo);
  }
}
```

---

## 11. Shared Utility Reference

| Need | Use |
|---|---|
| Navigate forward | `Get.toNamed(AppRoutes.x)` |
| Navigate & clear stack | `Get.offAllNamed(AppRoutes.x)` |
| Bottom sheet | `AppSheets.get.showBottomSheet(widget, isDismissible:)` |
| Error snackbar | `ClientSnacks.appStyledSnack(title:, state: UtilState.error)` |
| Success snackbar | `ClientSnacks.appStyledSnack(title:, state: UtilState.success)` |
| Conditional widget | `ConditionalBuilder(condition:, onBuild:, onFeedBack:)` |
| Loading spinner | `AppLoader()` |
| Generic image | `ImageGeneric.asset(url:, options: ImageOptions(height:, width:))` |
| Translate string | `'key'.toTr()` |
| Debug log | `log('msg', name: 'ClassName')` from `dart:developer` |
| Spacing (vertical) | `16.ESH()` |
| Spacing (horizontal) | `8.ESW()` |
| Screen padding | `AppInsets.defaultScreenHorizontal` / `AppInsets.defaultScreenALL` |

---

## 12. UI / Styling

- **Colors:** `AppColors.get.*` — `LightColor()` / `DarkColor()` implement `ColorInterface`
- **Text weights:** use `FW.*` enum (`FW.bold`, `FW.medium`, `FW.semiBold`)
- **Checkbox / toggles:** `activeColor: AppColors.get.primary`
- **Theme:** `ThemeData` wired in `AppMaterial` — `themes.dart` is currently commented WIP
- **Dark mode:** `AppColors.changeColor(isDark:, update:)` — add tokens to both `LightColor` and `DarkColor`

---

## 13. App Modes

| Mode | Behaviour |
|---|---|
| `AppMode.prod` | Real HTTP via `handleCall` |
| `AppMode.dev` | Returns `devData` — no network |
| `AppMode.test` | Returns `testData` — no network |

Always provide `testData` in every new `Repository`.

---

## 14. Commands Reference

```bash
flutter analyze .                                          # lint
flutter test .                                            # tests
dart run build_runner build --delete-conflicting-outputs  # codegen
flutter pub add <package>                                 # add dep
```

---

## 15. Prohibited → Correct Patterns

| ❌ Prohibited | ✅ Correct |
|---|---|
| `print('x')` | `log('x', name: 'Foo')` |
| `state.data!` without guard | `if (state.data != null) { state.data }` |
| `Colors.blue` / `Color(0xFF…)` | `AppColors.get.primary` |
| `SizedBox(height: 16)` | `16.ESH()` |
| `Text('Hello')` in pages | `CustomText('Hello')` |
| `Navigator.push(…)` | `Get.toNamed(AppRoutes.x)` |
| Riverpod / Bloc / Provider | GetX only |
| go_router | GetX named routes only |
| `google_fonts` package | Bundled URW / Montserrat fonts |
| `try-catch` around `useCase()` | Trust `DataFailed` return |

---

## 16. Pre-Commit Quality Checklist

- [ ] `flutter analyze .` — zero errors
- [ ] No `print()` in any modified file
- [ ] All `TextEditingController`s disposed in `onClose()`
- [ ] New route in `AppRoutes` **and** `AppRouter.pages`
- [ ] New API URL in `ApiNames` mixin
- [ ] `testData` provided in every new `Repository`
- [ ] `const` constructors used wherever applicable
