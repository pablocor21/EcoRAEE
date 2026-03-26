# EcoRAEE — Flutter Agents Guide

> **Arquitectura:** Clean Architecture + Feature-Based  
> **Stack:** Flutter 3.x · Riverpod · Dio · go_router · get_it · dartz  
> **Plataformas:** iOS · Android  
> **Versión:** 1.0.0

---

## Índice

1. [Principios de arquitectura](#1-principios-de-arquitectura)
2. [Estructura global del proyecto](#2-estructura-global-del-proyecto)
3. [Core — código transversal](#3-core--código-transversal)
4. [Feature: auth](#4-feature-auth)
5. [Feature: dispositivo](#5-feature-dispositivo)
6. [Feature: solicitud](#6-feature-solicitud)
7. [Feature: trazabilidad](#7-feature-trazabilidad)
8. [Feature: punto](#8-feature-punto)
9. [Feature: reciclaje](#9-feature-reciclaje)
10. [Feature: incentivo](#10-feature-incentivo)
11. [Feature: notificacion](#11-feature-notificacion)
12. [Feature: reporte](#12-feature-reporte)
13. [Inyección de dependencias](#13-inyección-de-dependencias)
14. [Navegación — go_router](#14-navegación--go_router)
15. [Convenciones de código](#15-convenciones-de-código)
16. [Dependencias pubspec.yaml](#16-dependencias-pubspecyaml)

---

## 1. Principios de arquitectura

### Clean Architecture

El proyecto sigue Clean Architecture con tres capas por feature. Las dependencias **solo apuntan hacia adentro**:

```
Presentación  →  Dominio  ←  Datos
```

- **Dominio** no depende de Flutter ni de ningún paquete externo. Es Dart puro.
- **Datos** implementa las interfaces que define el dominio.
- **Presentación** solo conoce el dominio a través de use cases.

### Reglas estrictas

| Regla | Descripción |
|---|---|
| Controller → solo su Service | Un `Notifier` solo inyecta use cases de su propia feature |
| No cross-feature imports | Una feature no importa clases internas de otra feature |
| Entidades son Dart puro | Ninguna entity tiene `fromJson` ni depende de Dio |
| Failures con Either | Todos los use cases retornan `Either<Failure, T>` |
| Un use case = una acción | Cada use case hace exactamente una cosa |

### Feature-based

Cada módulo de negocio vive en su propia carpeta bajo `lib/features/`. Agregar, eliminar o refactorizar una feature no afecta las demás.

```
features/
├── auth/
├── dispositivo/
├── solicitud/
├── trazabilidad/
├── punto/
├── reciclaje/
├── incentivo/
├── notificacion/
└── reporte/
```

---

## 2. Estructura global del proyecto

```
lib/
├── main.dart                        # Entrada: ProviderScope + runApp
├── injection_container.dart         # get_it: registro de todas las dependencias
│
├── core/                            # Código compartido por TODAS las features
│   ├── api/
│   │   └── api_client.dart          # Dio + interceptor JWT + base URL
│   ├── error/
│   │   ├── failure.dart             # Clase base Failure y subclases
│   │   └── exceptions.dart          # ServerException, CacheException, etc.
│   ├── router/
│   │   └── app_router.dart          # go_router con rutas protegidas por rol
│   ├── theme/
│   │   └── app_theme.dart           # ThemeData light y dark
│   └── utils/
│       └── date_formatter.dart      # Formatos de fecha reutilizables
│
└── features/
    ├── auth/
    ├── dispositivo/
    ├── solicitud/
    ├── trazabilidad/
    ├── punto/
    ├── reciclaje/
    ├── incentivo/
    ├── notificacion/
    └── reporte/
```

### Estructura interna de cada feature

```
features/<nombre>/
├── domain/
│   ├── entities/        # Clases Dart puras — el modelo de negocio
│   ├── usecases/        # Una clase por acción, retorna Either<Failure, T>
│   ├── repositories/    # Abstract class — el contrato que datos implementa
│   └── failures/        # Failures específicos de esta feature
├── data/
│   ├── models/          # Extienden la entity, agregan fromJson/toJson
│   ├── datasources/     # Llamadas HTTP con Dio o cache local
│   └── repositories/    # Implementación concreta del repositorio
└── presentation/
    ├── screens/         # Widgets de pantalla completa
    ├── providers/       # Notifiers (Riverpod) y States
    └── widgets/         # Widgets reutilizables dentro de la feature
```

---

## 3. Core — código transversal

### `core/error/failure.dart`

Clase base de todos los errores del sistema. Cada feature puede definir sus propios subtipos.

```dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure     extends Failure { const ServerFailure(super.message); }
class NetworkFailure    extends Failure { const NetworkFailure(super.message); }
class CacheFailure      extends Failure { const CacheFailure(super.message); }
class UnauthorizedFailure extends Failure { const UnauthorizedFailure(super.message); }
class NotFoundFailure   extends Failure { const NotFoundFailure(super.message); }
```

### `core/api/api_client.dart`

- Base URL configurada por entorno (`const String.fromEnvironment`)
- Interceptor que inyecta el JWT en cada request desde `SharedPreferences`
- Interceptor que captura 401 y redirige al login
- Timeout de 30 segundos en connect y receive

**Responsabilidades:**
- Configurar `Dio` con `BaseOptions`
- Agregar `InterceptorsWrapper` para JWT
- Exponer el `Dio` singleton registrado en `get_it`

### `core/router/app_router.dart`

- Usa `go_router` con `redirect` global
- Rutas protegidas: verifican `AuthNotifier.state` antes de navegar
- Ciudadano y Empresa ven rutas distintas según su rol
- Rutas de error para 404 y acceso denegado

### `core/theme/app_theme.dart`

- `ThemeData` con `ColorScheme.fromSeed`
- Color semilla: verde `#4ade80` (identidad EcoRAEE)
- Tipografía: `GoogleFonts` o fuente del sistema
- Soporte automático light/dark con `ThemeMode.system`

---

## 4. Feature: auth

**Propósito:** Registro, login y gestión de sesión. Genera y persiste el JWT. El rol del usuario determina qué rutas ve.

**Endpoints que consume:**
- `POST /api/auth/login`
- `POST /api/auth/register`

**Usuarios:** CIUDADANO, EMPRESA

---

### `domain/entities/usuario_entity.dart`

```
UsuarioEntity
├── id: int
├── nombre: String
├── email: String
├── telefono: String?
├── rol: RolUsuario          // enum: ciudadano, empresa
└── activo: bool
```

### `domain/failures/auth_failure.dart`

```
AuthFailure (extends Failure)
├── InvalidCredentialsFailure
├── EmailAlreadyExistsFailure
└── SessionExpiredFailure
```

### `domain/repositories/auth_repository.dart`

```dart
abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login(String email, String password);
  Future<Either<Failure, UsuarioEntity>> register(RegisterParams params);
  Future<Either<Failure, UsuarioEntity>> getUsuarioActual();
  Future<Either<Failure, void>> logout();
}
```

### `domain/usecases/`

| Archivo | Clase | Parámetros | Retorno |
|---|---|---|---|
| `login_usecase.dart` | `LoginUseCase` | `LoginParams(email, password)` | `Either<Failure, AuthToken>` |
| `register_usecase.dart` | `RegisterUseCase` | `RegisterParams(nombre, email, password, rol)` | `Either<Failure, UsuarioEntity>` |

### `data/models/auth_model.dart`

```
AuthModel
├── token: String
├── tipo: String             // "Bearer"
└── usuario: UsuarioModel

UsuarioModel (extends UsuarioEntity)
├── fromJson(Map<String, dynamic>)
└── toJson() → Map<String, dynamic>
```

### `data/datasources/`

**`auth_remote_ds.dart`** — llamadas HTTP:
- `login(email, password)` → POST `/api/auth/login`
- `register(RegisterParams)` → POST `/api/auth/register`
- Lanza `ServerException` si el status code es 4xx/5xx

**`token_local_ds.dart`** — persistencia JWT:
- `saveToken(String token)` → guarda en `SharedPreferences`
- `getToken()` → lee de `SharedPreferences`
- `deleteToken()` → elimina en logout

### `data/repositories/auth_repo_impl.dart`

Implementa `AuthRepository`. Orquesta `AuthRemoteDs` y `TokenLocalDs`. Captura excepciones y las convierte a `Failure`.

### `presentation/providers/auth_state.dart`

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial()                          = _Initial;
  const factory AuthState.loading()                          = _Loading;
  const factory AuthState.authenticated(UsuarioEntity user)  = _Authenticated;
  const factory AuthState.unauthenticated()                  = _Unauthenticated;
  const factory AuthState.error(String message)              = _Error;
}
```

### `presentation/providers/auth_notifier.dart`

```
AuthNotifier (extends AsyncNotifier<AuthState>)
├── login(email, password)       → llama LoginUseCase
├── register(RegisterParams)     → llama RegisterUseCase
├── logout()                     → borra token, emite unauthenticated
└── checkSession()               → verifica token al abrir la app
```

### `presentation/screens/`

| Pantalla | Descripción |
|---|---|
| `login_screen.dart` | Form email + contraseña. Botón "Iniciar sesión". Link a registro. |
| `register_screen.dart` | Form nombre, email, contraseña. Selector de rol con dos opciones: Ciudadano / Empresa. |

### `presentation/widgets/`

| Widget | Descripción |
|---|---|
| `auth_form_field.dart` | `TextFormField` con validación integrada, estilo consistente con el tema |

---

## 5. Feature: dispositivo

**Propósito:** Registrar y listar los RAEE del ciudadano. Incluye selección de categoría desde el backend y subida de foto.

**Endpoints que consume:**
- `GET /api/dispositivos`
- `POST /api/dispositivos` (multipart para foto)
- `GET /api/categorias`

**Usuarios:** CIUDADANO

---

### `domain/entities/`

**`dispositivo_entity.dart`**
```
DispositivoEntity
├── id: int
├── marca: String
├── modelo: String?
├── serialNumero: String?
├── descripcion: String?
├── fotoUrl: String?
├── estado: EstadoDispositivo    // enum: registrado, enProceso, recolectado, enReciclaje, reciclado, cancelado
├── anioFabricacion: int
├── categoria: CategoriaEntity
└── fechaRegistro: DateTime
```

**`categoria_entity.dart`**
```
CategoriaEntity
├── id: int
├── nombre: String               // "Celular", "Computador", etc.
├── icono: String                // emoji representativo
├── puntosBase: int
└── co2PromedioKg: double
```

### `domain/failures/dispositivo_failure.dart`

```
DispositivoFailure (extends Failure)
├── DispositivoNoEncontradoFailure
└── CategoriaNoDisponibleFailure
```

### `domain/repositories/dispositivo_repository.dart`

```dart
abstract class DispositivoRepository {
  Future<Either<Failure, List<DispositivoEntity>>> getMisDispositivos();
  Future<Either<Failure, DispositivoEntity>> registrar(RegistrarDispositivoParams params);
  Future<Either<Failure, List<CategoriaEntity>>> getCategorias();
}
```

### `domain/usecases/`

| Archivo | Clase | Parámetros | Retorno |
|---|---|---|---|
| `get_dispositivos.dart` | `GetDispositivos` | ninguno | `Either<Failure, List<DispositivoEntity>>` |
| `registrar_dispositivo.dart` | `RegistrarDispositivo` | `RegistrarDispositivoParams` | `Either<Failure, DispositivoEntity>` |

**`RegistrarDispositivoParams`:**
```
categoriaId: int
marca: String
modelo: String?
anioFabricacion: int
descripcion: String?
fotoPath: String?            // ruta local de la imagen seleccionada
```

### `data/models/`

**`dispositivo_model.dart`** — extiende `DispositivoEntity`, añade:
- `fromJson(Map<String, dynamic>)`
- `toJson()`
- `toEntity()` → convierte a `DispositivoEntity`

**`categoria_model.dart`** — misma estructura.

### `data/datasources/dispositivo_remote_ds.dart`

- `getMisDispositivos()` → GET `/api/dispositivos`
- `registrar(params)` → POST `/api/dispositivos` con `FormData` (multipart) si hay foto
- `getCategorias()` → GET `/api/categorias`

### `presentation/providers/dispositivo_state.dart`

```dart
@freezed
class DispositivoState with _$DispositivoState {
  const factory DispositivoState.initial()                                    = _Initial;
  const factory DispositivoState.loading()                                    = _Loading;
  const factory DispositivoState.loaded(List<DispositivoEntity> dispositivos) = _Loaded;
  const factory DispositivoState.registrando()                                = _Registrando;
  const factory DispositivoState.registrado(DispositivoEntity dispositivo)    = _Registrado;
  const factory DispositivoState.error(String message)                        = _Error;
}
```

### `presentation/providers/dispositivo_notifier.dart`

```
DispositivoNotifier (extends AsyncNotifier<DispositivoState>)
├── cargarMisDispositivos()    → llama GetDispositivos
├── registrar(params)          → llama RegistrarDispositivo
└── categorias: AsyncValue<List<CategoriaEntity>>   → cargadas al init
```

### `presentation/screens/`

| Pantalla | Descripción |
|---|---|
| `dispositivos_screen.dart` | Lista de dispositivos con `DispositivoCard`. Estado vacío con CTA. |
| `registrar_screen.dart` | Grid de categorías + form de marca/modelo/año + selector de foto con `image_picker`. |

### `presentation/widgets/`

| Widget | Descripción |
|---|---|
| `dispositivo_card.dart` | Tarjeta con icono de categoría, marca, modelo y chip de estado coloreado según `EstadoDispositivo`. |

---

## 6. Feature: solicitud

**Propósito:** Ciclo completo de recolección. El ciudadano crea la solicitud; la empresa la gestiona. La misma feature sirve a ambos roles con screens distintas.

**Endpoints que consume:**
- `POST /api/solicitudes`
- `GET /api/solicitudes` (filtrado por rol en backend)
- `PUT /api/solicitudes/{id}/estado`

**Usuarios:** CIUDADANO (crear, ver mis solicitudes), EMPRESA (gestionar, cambiar estado)

---

### `domain/entities/solicitud_entity.dart`

```
SolicitudEntity
├── id: int
├── dispositivoId: int
├── ciudadanoNombre: String
├── empresaNombre: String?
├── tipoRecoleccion: TipoRecoleccion    // enum: domicilio, puntoRecoleccion
├── direccionRecoleccion: String?
├── fechaPreferida: DateTime?
├── estado: EstadoSolicitud             // enum: pendiente, aceptada, enTransito, recolectada, completada, cancelada, rechazada
├── comentarioEmpresa: String?
└── fechaCreacion: DateTime
```

### `domain/failures/solicitud_failure.dart`

```
SolicitudFailure (extends Failure)
├── SolicitudNoEncontradaFailure
├── EstadoInvalidoFailure
└── DispositivoYaEnProcesoFailure
```

### `domain/repositories/solicitud_repository.dart`

```dart
abstract class SolicitudRepository {
  Future<Either<Failure, List<SolicitudEntity>>> getMisSolicitudes();
  Future<Either<Failure, List<SolicitudEntity>>> getSolicitudesPendientes();
  Future<Either<Failure, SolicitudEntity>> crear(CrearSolicitudParams params);
  Future<Either<Failure, SolicitudEntity>> cambiarEstado(int id, EstadoSolicitud estado, String? comentario);
}
```

### `domain/usecases/`

| Archivo | Clase | Parámetros | Retorno |
|---|---|---|---|
| `get_solicitudes.dart` | `GetSolicitudes` | ninguno | `Either<Failure, List<SolicitudEntity>>` |
| `crear_solicitud.dart` | `CrearSolicitud` | `CrearSolicitudParams` | `Either<Failure, SolicitudEntity>` |
| `cambiar_estado.dart` | `CambiarEstadoSolicitud` | `id, estado, comentario?` | `Either<Failure, SolicitudEntity>` |

**`CrearSolicitudParams`:**
```
dispositivoId: int
tipoRecoleccion: TipoRecoleccion
direccion: String?
puntoRecoleccionId: int?
fechaPreferida: DateTime?
observaciones: String?
```

### `presentation/providers/solicitud_state.dart`

```dart
@freezed
class SolicitudState with _$SolicitudState {
  const factory SolicitudState.initial()                                  = _Initial;
  const factory SolicitudState.loading()                                  = _Loading;
  const factory SolicitudState.loaded(List<SolicitudEntity> solicitudes)  = _Loaded;
  const factory SolicitudState.creando()                                  = _Creando;
  const factory SolicitudState.creada(SolicitudEntity solicitud)          = _Creada;
  const factory SolicitudState.error(String message)                      = _Error;
}
```

### `presentation/screens/`

| Pantalla | Rol | Descripción |
|---|---|---|
| `mis_solicitudes_screen.dart` | Ciudadano | Lista con `SolicitudCard`, filtrables por estado. |
| `crear_solicitud_screen.dart` | Ciudadano | Selector tipo (domicilio/punto), dirección o selección de punto, fecha preferida. |
| `gestion_solicitudes_screen.dart` | Empresa | Lista de pendientes con botones "Aceptar" / "Rechazar". Tabs: pendientes / en curso / completadas. |

### `presentation/widgets/`

| Widget | Descripción |
|---|---|
| `solicitud_card.dart` | Muestra nombre del ciudadano, tipo de dispositivo, tipo de recolección y chip de estado. |

---

## 7. Feature: trazabilidad

**Propósito:** Mostrar el historial completo de movimientos de un dispositivo como un timeline vertical. Solo lectura para el ciudadano; la empresa registra nuevos movimientos.

**Endpoints que consume:**
- `GET /api/movimientos/{dispositivoId}`
- `POST /api/movimientos`

**Usuarios:** CIUDADANO (solo lectura), EMPRESA (lectura + registrar movimientos)

---

### `domain/entities/`

**`tipo_movimiento.dart`**
```dart
enum TipoMovimiento {
  registro,
  solicitudCreada,
  aceptado,
  enTransito,
  recibidoPunto,
  recibidoEmpresa,
  enClasificacion,
  enDesmantelamiento,
  enReciclaje,
  reciclado,
  certificadoEmitido;

  String get icono => switch (this) {
    registro            => '📱',
    solicitudCreada     => '📋',
    aceptado            => '✅',
    enTransito          => '🚚',
    recibidoPunto       => '📍',
    recibidoEmpresa     => '🏭',
    enClasificacion     => '🔍',
    enDesmantelamiento  => '🔧',
    enReciclaje         => '♻️',
    reciclado           => '🌿',
    certificadoEmitido  => '📄',
  };

  String get label => switch (this) {
    registro            => 'Dispositivo registrado',
    solicitudCreada     => 'Solicitud creada',
    aceptado            => 'Solicitud aceptada',
    enTransito          => 'En tránsito',
    recibidoPunto       => 'Recibido en punto',
    recibidoEmpresa     => 'Recibido en empresa',
    enClasificacion     => 'En clasificación',
    enDesmantelamiento  => 'En desmantelamiento',
    enReciclaje         => 'En proceso de reciclaje',
    reciclado           => 'Reciclaje completado',
    certificadoEmitido  => 'Certificado emitido',
  };
}
```

**`movimiento_entity.dart`**
```
MovimientoEntity
├── id: int
├── tipo: TipoMovimiento
├── descripcion: String?
├── ubicacionOrigen: String?
├── ubicacionDestino: String?
├── latitud: double?
├── longitud: double?
├── evidenciaUrl: String?
├── responsableNombre: String
└── fecha: DateTime
```

### `domain/repositories/movimiento_repository.dart`

```dart
abstract class MovimientoRepository {
  Future<Either<Failure, List<MovimientoEntity>>> getTrazabilidad(int dispositivoId);
  Future<Either<Failure, MovimientoEntity>> registrar(RegistrarMovimientoParams params);
}
```

### `domain/usecases/get_trazabilidad.dart`

```
GetTrazabilidad
└── call(int dispositivoId) → Either<Failure, List<MovimientoEntity>>
     Lista ordenada por fecha ASC — el más antiguo primero
```

### `presentation/providers/trazabilidad_state.dart`

```dart
@freezed
class TrazabilidadState with _$TrazabilidadState {
  const factory TrazabilidadState.initial()                                   = _Initial;
  const factory TrazabilidadState.loading()                                   = _Loading;
  const factory TrazabilidadState.loaded(List<MovimientoEntity> movimientos)  = _Loaded;
  const factory TrazabilidadState.error(String message)                       = _Error;
}
```

### `presentation/screens/trazabilidad_screen.dart`

- Recibe `dispositivoId` como parámetro de ruta
- Muestra header con marca/modelo del dispositivo y chip de estado actual
- `ListView.builder` con `TimelineTile` por cada movimiento
- El último movimiento tiene estilo "activo" (color ámbar)
- Si el último movimiento es `certificadoEmitido`, muestra botón de descarga

### `presentation/widgets/timeline_tile.dart`

```
TimelineTile
├── Columna izquierda: círculo de color + línea vertical
│   ├── completado: verde con icono del movimiento
│   ├── activo: ámbar con glow
│   └── pendiente: gris tenue
└── Tarjeta derecha: título del movimiento, descripción, fecha
    └── borde izquierdo coloreado si es el activo
```

---

## 8. Feature: punto

**Propósito:** Mapa interactivo con todos los puntos de recolección. El ciudadano los consulta para entregar dispositivos. La empresa puede crear nuevos puntos.

**Endpoints que consume:**
- `GET /api/puntos-recoleccion`
- `POST /api/puntos-recoleccion`

**Paquetes clave:** `google_maps_flutter`, `geolocator`

**Usuarios:** CIUDADANO (ver mapa), EMPRESA (ver + crear puntos)

---

### `domain/entities/punto_entity.dart`

```
PuntoEntity
├── id: int
├── nombre: String
├── direccion: String
├── barrio: String?
├── ciudad: String
├── latitud: double
├── longitud: double
├── descripcion: String?
├── horarioAtencion: String?
├── telefono: String?
├── tiposAceptados: List<String>   // ["CELULAR", "COMPUTADOR", ...]
├── empresaNombre: String
└── activo: bool
```

### `domain/usecases/`

| Archivo | Clase | Descripción |
|---|---|---|
| `get_puntos_cercanos.dart` | `GetPuntosCercanos` | Carga todos los puntos; el filtro por distancia se hace en el Notifier con `geolocator` |
| `crear_punto.dart` | `CrearPunto` | Solo EMPRESA — crea un nuevo punto de recolección |

### `presentation/screens/`

| Pantalla | Descripción |
|---|---|
| `puntos_mapa_screen.dart` | `GoogleMap` con marcadores por cada punto. Al tocar un marcador muestra `PuntoDetalleSheet`. Botón FAB para crear punto (solo EMPRESA). |
| `crear_punto_screen.dart` | Form nombre, dirección, horario, tipos aceptados. El usuario toca el mapa para seleccionar coordenadas. |

### `presentation/widgets/punto_detalle_sheet.dart`

`DraggableScrollableSheet` con:
- Nombre y empresa del punto
- Dirección y horario
- Chips de tipos de RAEE aceptados
- Botón "Cómo llegar" → abre navegador externo con `url_launcher`

---

## 9. Feature: reciclaje

**Propósito:** La empresa registra el proceso formal de reciclaje de un dispositivo, incluyendo metodología, peso, CO₂ evitado y certificado PDF.

**Endpoints que consume:**
- `POST /api/reciclaje`
- `GET /api/reciclaje/{dispositivoId}`

**Paquetes clave:** `file_picker`

**Usuarios:** EMPRESA

---

### `domain/entities/`

**`metodologia_reciclaje.dart`**
```dart
enum MetodologiaReciclaje {
  desmontajeManual,
  tratamientoMecanico,
  recuperacionMateriales,
  disposicionFinalSegura,
  refabricacion,
  reutilizacion;

  String get label => switch (this) {
    desmontajeManual        => 'Desmontaje manual',
    tratamientoMecanico     => 'Tratamiento mecánico',
    recuperacionMateriales  => 'Recuperación de materiales',
    disposicionFinalSegura  => 'Disposición final segura',
    refabricacion           => 'Refabricación',
    reutilizacion           => 'Reutilización',
  };

  String get icono => switch (this) {
    desmontajeManual        => '🔧',
    tratamientoMecanico     => '⚙️',
    recuperacionMateriales  => '🔄',
    disposicionFinalSegura  => '🛡️',
    refabricacion           => '🏗️',
    reutilizacion           => '♻️',
  };
}
```

**`reciclaje_entity.dart`**
```
ReciclajeEntity
├── id: int
├── dispositivoId: int
├── empresaId: int
├── metodologia: MetodologiaReciclaje
├── fechaInicio: DateTime
├── fechaFin: DateTime?
├── pesoKg: double?
├── co2EvitadoKg: double?
├── materialesRecuperados: String?
├── certificadoUrl: String?
├── numeroCertificado: String?
└── estado: EstadoReciclaje    // enum: enProceso, completado, certificado
```

### `domain/usecases/registrar_reciclaje.dart`

```
RegistrarReciclaje
└── call(RegistrarReciclajeParams) → Either<Failure, ReciclajeEntity>

RegistrarReciclajeParams
├── dispositivoId: int
├── metodologia: MetodologiaReciclaje
├── fechaInicio: DateTime
├── pesoKg: double?
├── co2EvitadoKg: double?
├── materialesRecuperados: String?
└── certificadoPath: String?   // ruta local del PDF
```

### `presentation/screens/`

| Pantalla | Descripción |
|---|---|
| `registrar_reciclaje_screen.dart` | Grid de metodologías → form peso y CO₂ → picker de archivo PDF para certificado → botón guardar. |
| `reciclaje_detalle_screen.dart` | Resumen del proceso: metodología, fechas, métricas. Botón para descargar el certificado. |

### `presentation/widgets/metodologia_selector.dart`

`GridView` de 2 columnas con tarjetas seleccionables. Cada tarjeta muestra icono + nombre de la metodología. La seleccionada tiene borde y fondo del color primario.

---

## 10. Feature: incentivo

**Propósito:** Muestra al ciudadano sus puntos acumulados, historial de eventos y el ranking top 10. Genera el certificado ambiental personal en PDF.

**Endpoints que consume:**
- `GET /api/puntos/mis-puntos`
- `GET /api/puntos/ranking`
- `GET /api/puntos/historial`

**Paquetes clave:** `pdf`, `printing`

**Usuarios:** CIUDADANO

---

### `domain/entities/`

**`puntos_entity.dart`**
```
PuntosEntity
├── puntosTotal: int
├── dispositivosEntregados: int
├── co2EvitadoKg: double
├── pesoTotalKg: double
└── posicionRanking: int
```

**`historial_evento.dart`**
```
HistorialEventoEntity
├── id: int
├── tipo: String            // "DISPOSITIVO_REGISTRADO", "RECICLAJE_CERTIFICADO", etc.
├── puntos: int             // positivo: ganó, negativo: descontó
├── descripcion: String
└── fecha: DateTime
```

### `domain/usecases/`

| Archivo | Clase | Retorno |
|---|---|---|
| `get_mis_puntos.dart` | `GetMisPuntos` | `Either<Failure, PuntosEntity>` |
| `get_ranking.dart` | `GetRanking` | `Either<Failure, List<RankingItemEntity>>` |
| `get_historial.dart` | `GetHistorial` | `Either<Failure, List<HistorialEventoEntity>>` |

### `presentation/screens/`

**`puntos_screen.dart`** — 3 tabs con `TabBar`:

| Tab | Contenido |
|---|---|
| Resumen | Tarjeta grande con total de puntos + posición en ranking. Métricas: dispositivos, CO₂, peso. Tabla "Cómo ganar puntos". Botón "Descargar certificado". |
| Ranking | `ListView` de `RankingTile` con medallas para top 3. |
| Historial | `ListView` de eventos con puntos ganados y fecha. |

**`ranking_screen.dart`** — pantalla dedicada al ranking si se navega desde otra feature.

### `presentation/widgets/`

| Widget | Descripción |
|---|---|
| `ranking_tile.dart` | Fila con medalla (🥇🥈🥉 o posición numérica), nombre, dispositivos, CO₂ y puntos. |
| `certificado_sheet.dart` | `BottomSheet` con preview del certificado (nombre, puntos, CO₂, fecha). Botón genera PDF con el paquete `pdf` y lo comparte con `printing`. |

### Tabla de puntos por evento

| Evento | Puntos |
|---|---|
| Registrar dispositivo | +10 |
| Bonus primer dispositivo | +30 |
| Recolección completada | +20 |
| Reciclaje certificado | +50 |
| Bonus CO₂ evitado | +5 por kg |

---

## 11. Feature: notificacion

**Propósito:** Recibir notificaciones push via Firebase Cloud Messaging cuando cambia el estado del dispositivo. Centro de notificaciones con badge de no leídas.

**Endpoints que consume:**
- `GET /api/notificaciones`
- `PUT /api/notificaciones/{id}/leida`

**Paquetes clave:** `firebase_messaging`, `flutter_local_notifications`

**Usuarios:** CIUDADANO, EMPRESA

---

### `domain/entities/notificacion_entity.dart`

```
NotificacionEntity
├── id: int
├── titulo: String
├── mensaje: String
├── tipo: String             // "SOLICITUD_ACEPTADA", "RECICLAJE_COMPLETADO", etc.
├── leida: bool
├── referenciaId: int?       // ID del objeto referenciado (solicitud, dispositivo...)
├── referenciaTipo: String?  // "solicitud", "dispositivo", etc.
└── fechaCreacion: DateTime
```

### `domain/usecases/`

| Archivo | Clase | Descripción |
|---|---|---|
| `get_notificaciones.dart` | `GetNotificaciones` | Lista todas las notificaciones del usuario |
| `marcar_leida.dart` | `MarcarLeida` | Marca una notificación como leída por su `id` |

### `data/datasources/fcm_service.dart`

Responsabilidades:
- Solicitar permisos de notificación al usuario
- Inicializar `FirebaseMessaging` y `FlutterLocalNotificationsPlugin`
- Guardar el token FCM en el backend vía `PUT /api/usuarios/fcm-token`
- Escuchar mensajes en `onMessage` (foreground) y mostrarlos como notificación local
- Escuchar `onMessageOpenedApp` para navegar a la pantalla correspondiente según `referenciaTipo`

### `presentation/providers/notificacion_notifier.dart`

```
NotificacionNotifier
├── cargarNotificaciones()
├── marcarLeida(int id)
├── contadorNoLeidas: int    // badge en el ícono de la barra de navegación
└── escucharFCM()            // suscribe al stream de mensajes en background
```

### `presentation/screens/notificaciones_screen.dart`

- `AppBar` con título "Notificaciones" y botón "Marcar todas como leídas"
- `ListView` de `NotificacionTile`
- Notificaciones no leídas tienen fondo ligeramente resaltado y borde izquierdo de color
- Al tocar una notificación: marca como leída y navega a la pantalla correspondiente usando `referenciaTipo` + `referenciaId`

### `presentation/widgets/notificacion_tile.dart`

```
NotificacionTile
├── Icono según tipo de notificación
├── Título en negrita
├── Mensaje (2 líneas máximo, overflow: ellipsis)
├── Fecha relativa ("hace 10 min", "ayer")
└── Indicador de no leída (punto de color)
```

---

## 12. Feature: reporte

**Propósito:** La empresa consulta sus métricas ambientales por período: kg gestionados, CO₂ evitado y desglose por tipo de dispositivo. Puede exportar el reporte como PDF.

**Endpoints que consume:**
- `GET /api/reportes/ambiental?inicio=&fin=`

**Paquetes clave:** `fl_chart`, `pdf`, `printing`

**Usuarios:** EMPRESA

---

### `domain/entities/reporte_entity.dart`

```
ReporteEntity
├── periodoInicio: DateTime
├── periodoFin: DateTime
├── totalDispositivosGestionados: int
├── totalSolicitudesCompletadas: int
├── totalPesoKg: double
├── totalCo2EvitadoKg: double
└── desgloseDispositivos: Map<String, int>   // {"CELULAR": 23, "COMPUTADOR": 8, ...}
```

### `domain/usecases/get_reporte_ambiental.dart`

```
GetReporteAmbiental
└── call(GetReporteParams) → Either<Failure, ReporteEntity>

GetReporteParams
├── periodoInicio: DateTime
└── periodoFin: DateTime
```

### `presentation/screens/reporte_screen.dart`

Estructura de la pantalla:
1. **Selector de período** — `DateRangePicker` con atajos: este mes, este trimestre, este año
2. **Tarjetas de métricas** — `MetricaCard` para kg, CO₂ y solicitudes
3. **Gráfica de barras** — `BarChartWidget` con `fl_chart`, eje X = tipo de dispositivo, eje Y = cantidad
4. **Botón exportar** — genera PDF con `pdf` y comparte con `printing`

### `presentation/widgets/`

| Widget | Descripción |
|---|---|
| `bar_chart_widget.dart` | `BarChart` de `fl_chart`. Barras con color verde degradado. Tooltips al tocar. Eje X con etiquetas de tipo de dispositivo. |
| `metrica_card.dart` | Tarjeta con icono, valor grande y etiqueta descriptiva. Acepta un color de acento. |

---

## 13. Inyección de dependencias

Archivo: `lib/injection_container.dart`

Usa `get_it` como service locator. Se inicializa en `main.dart` antes de `runApp`.

```dart
final sl = GetIt.instance;

Future<void> init() async {
  // ── CORE ────────────────────────────────────────
  sl.registerLazySingleton(() => ApiClient(sl()));
  sl.registerLazySingleton(() => SharedPreferences.getInstance());

  // ── AUTH ────────────────────────────────────────
  // datasources
  sl.registerLazySingleton<AuthRemoteDs>(() => AuthRemoteDsImpl(sl()));
  sl.registerLazySingleton<TokenLocalDs>(() => TokenLocalDsImpl(sl()));
  // repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(sl(), sl()));
  // usecases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  // notifier — registrado como factory para que Riverpod lo cree
  sl.registerFactory(() => AuthNotifier(sl(), sl()));

  // ── DISPOSITIVO ─────────────────────────────────
  sl.registerLazySingleton<DispositivoRemoteDs>(() => DispositivoRemoteDsImpl(sl()));
  sl.registerLazySingleton<DispositivoRepository>(() => DispositivoRepoImpl(sl()));
  sl.registerLazySingleton(() => GetDispositivos(sl()));
  sl.registerLazySingleton(() => RegistrarDispositivo(sl()));

  // ... mismo patrón para cada feature
}
```

### Patrón de registro

| Tipo | Cuándo usar |
|---|---|
| `registerLazySingleton` | Datasources, repositories, use cases — una instancia para toda la app |
| `registerFactory` | Notifiers — Riverpod los crea y destruye según el ciclo de vida |
| `registerSingletonAsync` | `SharedPreferences` — requiere `await` en la inicialización |

---

## 14. Navegación — go_router

Archivo: `lib/core/router/app_router.dart`

### Rutas definidas

| Ruta | Pantalla | Acceso |
|---|---|---|
| `/login` | `LoginScreen` | Público |
| `/register` | `RegisterScreen` | Público |
| `/home` | Redirect según rol | Autenticado |
| `/dispositivos` | `DispositivosScreen` | CIUDADANO |
| `/dispositivos/registrar` | `RegistrarScreen` | CIUDADANO |
| `/dispositivos/:id/trazabilidad` | `TrazabilidadScreen` | CIUDADANO |
| `/solicitudes` | `MisSolicitudesScreen` | CIUDADANO |
| `/solicitudes/crear` | `CrearSolicitudScreen` | CIUDADANO |
| `/puntos` | `PuntosMapaScreen` | CIUDADANO, EMPRESA |
| `/puntos/crear` | `CrearPuntoScreen` | EMPRESA |
| `/incentivo` | `PuntosScreen` | CIUDADANO |
| `/notificaciones` | `NotificacionesScreen` | CIUDADANO, EMPRESA |
| `/empresa/solicitudes` | `GestionSolicitudesScreen` | EMPRESA |
| `/empresa/reciclaje/:dispositivoId` | `RegistrarReciclajeScreen` | EMPRESA |
| `/empresa/reportes` | `ReporteScreen` | EMPRESA |

### Guard de autenticación

```dart
redirect: (context, state) {
  final isLoggedIn = ref.read(authNotifierProvider).isAuthenticated;
  final isPublic = state.matchedLocation.startsWith('/login') ||
                   state.matchedLocation.startsWith('/register');

  if (!isLoggedIn && !isPublic) return '/login';
  if (isLoggedIn && isPublic) return '/home';
  return null;
}
```

---

## 15. Convenciones de código

### Nomenclatura de archivos

- `snake_case` para todos los archivos `.dart`
- Sufijo descriptivo obligatorio: `_screen`, `_notifier`, `_state`, `_entity`, `_model`, `_usecase`, `_repository`, `_ds`

### Nomenclatura de clases

- `PascalCase` para todas las clases
- Sufijo en el nombre de la clase igual al sufijo del archivo:
  - `DispositivoEntity`, `DispositivoModel`, `DispositivoRepository`
  - `GetDispositivos` (use case — verbo + sustantivo)
  - `DispositivoNotifier`, `DispositivoState`

### Use cases

```dart
class GetDispositivos {
  final DispositivoRepository _repo;
  GetDispositivos(this._repo);

  Future<Either<Failure, List<DispositivoEntity>>> call() async {
    return await _repo.getMisDispositivos();
  }
}
```

- Siempre tienen un método `call()` — se invocan como función: `getDispositivos()`
- Parámetros complejos van en una clase `Params` separada

### Notifiers con Riverpod

```dart
@riverpod
class DispositivoNotifier extends _$DispositivoNotifier {
  @override
  DispositivoState build() => const DispositivoState.initial();

  Future<void> cargar() async {
    state = const DispositivoState.loading();
    final result = await sl<GetDispositivos>()();
    state = result.fold(
      (failure) => DispositivoState.error(failure.message),
      (dispositivos) => DispositivoState.loaded(dispositivos),
    );
  }
}
```

### Manejo de errores en screens

```dart
ref.watch(dispositivoNotifierProvider).when(
  initial: () => const SizedBox.shrink(),
  loading: () => const CircularProgressIndicator(),
  loaded: (dispositivos) => _buildLista(dispositivos),
  error: (msg) => ErrorWidget(message: msg),
  // otros estados...
);
```

### Imports

Orden obligatorio:
1. `dart:` libraries
2. `package:flutter/`
3. Paquetes externos (`package:dio/`, `package:riverpod/`, etc.)
4. Imports internos del proyecto (`../../core/`, `../domain/`)

---

## 16. Dependencias pubspec.yaml

```yaml
name: ecoraee
description: Sistema integral de gestión de RAEE
version: 1.0.0+1

environment:
  sdk: ^3.0.0

dependencies:
  flutter:
    sdk: flutter

  # Estado
  flutter_riverpod:     ^2.4.0
  riverpod_annotation:  ^2.3.0

  # HTTP
  dio:                  ^5.4.0

  # Navegación
  go_router:            ^13.0.0

  # Inyección de dependencias
  get_it:               ^7.6.0

  # Manejo de errores (Either)
  dartz:                ^0.10.1

  # Modelos inmutables
  freezed_annotation:   ^2.4.0

  # Storage local
  shared_preferences:   ^2.2.2

  # Mapas
  google_maps_flutter:  ^2.5.0
  geolocator:           ^11.0.0

  # Imágenes
  image_picker:         ^1.0.7

  # Notificaciones push
  firebase_core:               ^2.25.0
  firebase_messaging:          ^14.7.0
  flutter_local_notifications: ^16.3.0

  # Gráficas
  fl_chart:             ^0.66.0

  # PDF
  pdf:                  ^3.10.7
  printing:             ^5.12.0

  # Archivos
  file_picker:          ^6.1.1

  # Fechas
  intl:                 ^0.19.0

  # Timeline
  timeline_tile:        ^2.0.0

  # URL externa
  url_launcher:         ^6.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  riverpod_generator:   ^2.3.0
  build_runner:         ^2.4.0
  freezed:              ^2.4.0
  json_serializable:    ^6.7.0
  flutter_lints:        ^3.0.0
```

---

*EcoRAEE Flutter — agents.md generado automáticamente · Versión 1.0.0*
