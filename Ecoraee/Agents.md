# Reglas de Desarrollo - Proyecto Ciclox (EcoRAEE)

Este documento define los estándares y guías de desarrollo para mantener la consistencia y escalabilidad del proyecto.

## 1. Estructura y Distribución del Proyecto

El proyecto sigue una arquitectura basada en **Clean Architecture** adaptada a Flutter, organizada por características (Features).

### Directorio Raíz del Código (`lib/`)

- **`config/`**: Configuraciones globales del proyecto.
  - `theme/`: Definición de colores, tipografías y temas (ej. `app_theme.dart`).
  - `router/`: Configuración de navegación con GoRouter (ej. `app_router.dart`).
  - `constants/`: Constantes globales y estáticas (ej. `app_constants.dart`).
- **`features/`**: Módulos funcionales del sistema. Cada feature debe seguir esta sub-estructura:
  - `domain/`: Capa de negocio pura (Entidades, Interfaces de Repositorios, Use Cases).
  - `infrastructure/`: Implementación de la capa de datos (Repositorios, DataSources, Mappers, DTOs).
  - `presentation/`: Capa de interfaz de usuario.
    - `providers/`: Gestión de estado con Riverpod.
    - `screens/`: Pantallas completas de la aplicación.
    - `widget/`: Componentes reutilizables específicos de la feature.
- **`main.dart`**: Punto de entrada de la aplicación.

---

## 2. Reglas de Nomenclatura

### Archivos
- **Snake Case**: Todo en minúsculas con guiones bajos.
  - Ejemplo: `login_screen.dart`, `auth_provider.dart`, `custom_textfield.dart`.
  - Los archivos de UI deben llevar un sufijo descriptivo (`_screen.dart`, `_widget.dart`).

### Clases
- **PascalCase**: Primera letra de cada palabra en mayúscula.
  - Ejemplo: `LoginScreen`, `AuthRepository`, `UserEntity`.
  - Los nombres deben ser sustantivos claros.

### Funciones y Métodos
- **camelCase**: Primera palabra en minúscula, las siguientes con la primera letra en mayúscula.
  - Ejemplo: `signIn()`, `getUserData()`, `validateForm()`.
  - Deben comenzar con un verbo que describa la acción.

### Variables y Parámetros
- **camelCase**: Igual que las funciones.
  - Ejemplo: `emailController`, `isLoading`, `success`.
- **Privacidad**: Las variables y métodos privados dentro de una clase o archivo deben comenzar con un guion bajo (`_`).
  - Ejemplo: `_formKey`, `_login()`, `_internalState`.

### Proveedores (Riverpod Providers)
- **camelCase**: Deben terminar con el sufijo `Provider` (o similar si es notifier).
  - Ejemplo: `authProvider`, `userProfileProvider`.

---

## 3. Estándares de Codificación y Mejores Prácticas

1.  **Gestión de Estado**: Usar **Riverpod** de forma mandatoria. Preferir `StateNotifier` o el nuevo patrón de `Generated Providers` ( @riverpod ) si está configurado.
2.  **Navegación**: Utilizar **GoRouter**. Definir todas las rutas en `lib/config/router/`.
3.  **UI/UX**:
    - Utilizar los colores definidos en la clase `CicloxColors`.
    - Mantener los widgets pequeños y modulares. Si un widget supera las 200 líneas, considerar extraer componentes a la carpeta `widget/`.
4.  **Internacionalización/Textos**: (Pendiente definir si se usará i18n, por ahora mantener constantes en español).
5.  **Manejo de Errores**:
    - Las excepciones de infraestructura no deben llegar a la capa de presentación.
    - Usar mappers para convertir errores de red en objetos de dominio entendibles.
6.  **Tipado**: Evitar el uso de `dynamic`. Siempre definir tipos explícitos para mejorar la mantenibilidad.

---

Este archivo es la fuente de verdad para el desarrollo. Cualquier cambio estructural debe ser reflejado aquí primero.
