# EcoRAEE — Estructura de Carpetas

## Árbol completo del proyecto

```
ecoraee/
├── lib/
│   ├── main.dart
│   ├── injection_container.dart
│   │
│   ├── core/
│   │   ├── api/
│   │   │   ├── api_client.dart
│   │   │   └── interceptors.dart
│   │   ├── error/
│   │   │   ├── failure.dart
│   │   │   └── exceptions.dart
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   └── utils/
│   │       └── date_formatter.dart
│   │
│   └── features/
│       ├── auth/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   ├── usuario_entity.dart
│       │   │   │   └── auth_token_entity.dart
│       │   │   ├── failures/
│       │   │   │   └── auth_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── auth_repository.dart
│       │   │   └── usecases/
│       │   │       ├── login_usecase.dart
│       │   │       ├── register_usecase.dart
│       │   │       └── logout_usecase.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   ├── auth_remote_ds.dart
│       │   │   │   └── token_local_ds.dart
│       │   │   ├── models/
│       │   │   │   ├── usuario_model.dart
│       │   │   │   └── auth_model.dart
│       │   │   └── repositories/
│       │   │       └── auth_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── auth_state.dart
│       │       │   ├── auth_notifier.dart
│       │       │   └── auth_provider.dart
│       │       ├── screens/
│       │       │   ├── login_screen.dart
│       │       │   └── register_screen.dart
│       │       └── widgets/
│       │           └── auth_form_field.dart
│       │
│       ├── dispositivo/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   ├── dispositivo_entity.dart
│       │   │   │   └── categoria_entity.dart
│       │   │   ├── failures/
│       │   │   │   └── dispositivo_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── dispositivo_repository.dart
│       │   │   └── usecases/
│       │   │       ├── get_dispositivos.dart
│       │   │       ├── registrar_dispositivo.dart
│       │   │       └── get_categorias.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── dispositivo_remote_ds.dart
│       │   │   ├── models/
│       │   │   │   ├── dispositivo_model.dart
│       │   │   │   └── categoria_model.dart
│       │   │   └── repositories/
│       │   │       └── dispositivo_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── dispositivo_state.dart
│       │       │   ├── dispositivo_notifier.dart
│       │       │   └── dispositivo_provider.dart
│       │       ├── screens/
│       │       │   ├── dispositivos_screen.dart
│       │       │   └── registrar_screen.dart
│       │       └── widgets/
│       │           └── dispositivo_card.dart
│       │
│       ├── solicitud/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── solicitud_entity.dart
│       │   │   ├── failures/
│       │   │   │   └── solicitud_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── solicitud_repository.dart
│       │   │   └── usecases/
│       │   │       ├── get_solicitudes.dart
│       │   │       ├── crear_solicitud.dart
│       │   │       └── cambiar_estado.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── solicitud_remote_ds.dart
│       │   │   ├── models/
│       │   │   │   └── solicitud_model.dart
│       │   │   └── repositories/
│       │   │       └── solicitud_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── solicitud_state.dart
│       │       │   ├── solicitud_notifier.dart
│       │       │   └── solicitud_provider.dart
│       │       ├── screens/
│       │       │   ├── mis_solicitudes_screen.dart
│       │       │   ├── crear_solicitud_screen.dart
│       │       │   └── gestion_solicitudes_screen.dart
│       │       └── widgets/
│       │           └── solicitud_card.dart
│       │
│       ├── trazabilidad/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   ├── movimiento_entity.dart
│       │   │   │   └── tipo_movimiento.dart
│       │   │   ├── failures/
│       │   │   │   └── trazabilidad_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── movimiento_repository.dart
│       │   │   └── usecases/
│       │   │       └── get_trazabilidad.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── movimiento_remote_ds.dart
│       │   │   ├── models/
│       │   │   │   └── movimiento_model.dart
│       │   │   └── repositories/
│       │   │       └── movimiento_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── trazabilidad_state.dart
│       │       │   ├── trazabilidad_notifier.dart
│       │       │   └── trazabilidad_provider.dart
│       │       ├── screens/
│       │       │   └── trazabilidad_screen.dart
│       │       └── widgets/
│       │           └── timeline_tile.dart
│       │
│       ├── punto/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── punto_entity.dart
│       │   │   ├── failures/
│       │   │   │   └── punto_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── punto_repository.dart
│       │   │   └── usecases/
│       │   │       ├── get_puntos_cercanos.dart
│       │   │       └── crear_punto.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── punto_remote_ds.dart
│       │   │   ├── models/
│       │   │   │   └── punto_model.dart
│       │   │   └── repositories/
│       │   │       └── punto_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── punto_state.dart
│       │       │   ├── punto_notifier.dart
│       │       │   └── punto_provider.dart
│       │       ├── screens/
│       │       │   ├── puntos_mapa_screen.dart
│       │       │   └── crear_punto_screen.dart
│       │       └── widgets/
│       │           └── punto_detalle_sheet.dart
│       │
│       ├── reciclaje/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   ├── reciclaje_entity.dart
│       │   │   │   └── metodologia_reciclaje.dart
│       │   │   ├── failures/
│       │   │   │   └── reciclaje_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── reciclaje_repository.dart
│       │   │   └── usecases/
│       │   │       └── registrar_reciclaje.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── reciclaje_remote_ds.dart
│       │   │   ├── models/
│       │   │   │   └── reciclaje_model.dart
│       │   │   └── repositories/
│       │   │       └── reciclaje_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── reciclaje_state.dart
│       │       │   ├── reciclaje_notifier.dart
│       │       │   └── reciclaje_provider.dart
│       │       ├── screens/
│       │       │   ├── registrar_reciclaje_screen.dart
│       │       │   └── reciclaje_detalle_screen.dart
│       │       └── widgets/
│       │           └── metodologia_selector.dart
│       │
│       ├── incentivo/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   ├── puntos_entity.dart
│       │   │   │   └── historial_evento_entity.dart
│       │   │   ├── failures/
│       │   │   │   └── incentivo_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── incentivo_repository.dart
│       │   │   └── usecases/
│       │   │       ├── get_mis_puntos.dart
│       │   │       ├── get_ranking.dart
│       │   │       └── get_historial.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── incentivo_remote_ds.dart
│       │   │   ├── models/
│       │   │   │   ├── puntos_model.dart
│       │   │   │   └── historial_evento_model.dart
│       │   │   └── repositories/
│       │   │       └── incentivo_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── incentivo_state.dart
│       │       │   ├── incentivo_notifier.dart
│       │       │   └── incentivo_provider.dart
│       │       ├── screens/
│       │       │   ├── puntos_screen.dart
│       │       │   └── ranking_screen.dart
│       │       └── widgets/
│       │           ├── ranking_tile.dart
│       │           └── certificado_sheet.dart
│       │
│       ├── notificacion/
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── notificacion_entity.dart
│       │   │   ├── failures/
│       │   │   │   └── notificacion_failure.dart
│       │   │   ├── repositories/
│       │   │   │   └── notificacion_repository.dart
│       │   │   └── usecases/
│       │   │       ├── get_notificaciones.dart
│       │   │       └── marcar_leida.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   ├── notificacion_remote_ds.dart
│       │   │   │   └── fcm_service.dart
│       │   │   ├── models/
│       │   │   │   └── notificacion_model.dart
│       │   │   └── repositories/
│       │   │       └── notificacion_repo_impl.dart
│       │   └── presentation/
│       │       ├── providers/
│       │       │   ├── notificacion_state.dart
│       │       │   ├── notificacion_notifier.dart
│       │       │   └── notificacion_provider.dart
│       │       ├── screens/
│       │       │   └── notificaciones_screen.dart
│       │       └── widgets/
│       │           └── notificacion_tile.dart
│       │
│       └── reporte/
│           ├── domain/
│           │   ├── entities/
│           │   │   └── reporte_entity.dart
│           │   ├── failures/
│           │   │   └── reporte_failure.dart
│           │   ├── repositories/
│           │   │   └── reporte_repository.dart
│           │   └── usecases/
│           │       └── get_reporte_ambiental.dart
│           ├── data/
│           │   ├── datasources/
│           │   │   └── reporte_remote_ds.dart
│           │   ├── models/
│           │   │   └── reporte_model.dart
│           │   └── repositories/
│           │       └── reporte_repo_impl.dart
│           └── presentation/
│               ├── providers/
│               │   ├── reporte_state.dart
│               │   ├── reporte_notifier.dart
│               │   └── reporte_provider.dart
│               ├── screens/
│               │   └── reporte_screen.dart
│               └── widgets/
│                   ├── bar_chart_widget.dart
│                   └── metrica_card.dart
│
├── pubspec.yaml
├── pubspec.lock
├── .gitignore
├── analysis_options.yaml
│
├── android/
├── ios/
├── web/
├── windows/
├── macos/
│
└── test/
    ├── features/
    └── core/
```

## Guía de nomenclatura

### Core
- **api/** → Cliente HTTP y interceptores
- **error/** → Clases de error base (Failure, Exception)
- **router/** → Navegación con go_router
- **theme/** → Tema de la aplicación
- **utils/** → Funciones utilitarias reutilizables

### Features (9 módulos independientes)
Cada feature tiene 3 capas:

#### 1️⃣ Domain (Lógica de negocio - Dart puro)
- `entities/` → Modelos de dominio
- `repositories/` → Interfaces abstractas
- `usecases/` → Casos de uso (una acción por archivo)
- `failures/` → Errores específicos del feature

#### 2️⃣ Data (Implementación de datos)
- `datasources/` → Llamadas HTTP (remote) o caché (local)
- `models/` → Extienden entities, agregan fromJson/toJson
- `repositories/` → Implementación concreta

#### 3️⃣ Presentation (UI - Flutter)
- `providers/` → Riverpod notifiers y states
- `screens/` → Widgets de pantalla completa
- `widgets/` → Componentes reutilizables

## Convenciones de nomenclatura

| Capa | Archivo | Clase | Ejemplo |
|---|---|---|---|
| **Domain** | `snake_case` | `PascalCase` | `usuario_entity.dart` → `UsuarioEntity` |
| **Domain** | `snake_case` | `PascalCase` | `login_usecase.dart` → `LoginUseCase` |
| **Data** | `snake_case` | `PascalCase` | `usuario_model.dart` → `UsuarioModel` |
| **Presentation** | `snake_case` | `PascalCase` | `login_screen.dart` → `LoginScreen` |

## Reglas estrictas

✅ **CORRECTO:**
- Un use case por archivo
- Notifier solo inyecta use cases de su feature
- Entities son Dart puro (sin fromJson)
- Models extienden entities

❌ **INCORRECTO:**
- Cross-feature imports
- Múltiples use cases en un archivo
- Entities con dependencias externas
