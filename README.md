# Qar App - Control de Acceso Vehicular

![Qar App Logo](https://via.placeholder.com/150) <!-- Reemplaza con la URL del logo de la aplicación -->

**Qar App** es una aplicación móvil diseñada para facilitar el control de acceso vehicular en instituciones. La aplicación permite registrar vehículos, escanear códigos QR para verificar el acceso, y mantener un historial de accesos para fines de seguridad. Desarrollada con **Flutter** y **Dart**, Qar App ofrece una interfaz intuitiva y fácil de usar para el personal de seguridad.

## Características Principales

- **Registro de Vehículos**: Permite registrar nuevos vehículos con detalles como placa, propietario, tipo de vehículo y más.
- **Generación de Códigos QR**: Genera un código QR único para cada vehículo registrado.
- **Escaneo de Códigos QR**: Utiliza la cámara del dispositivo para escanear códigos QR y verificar el acceso.
- **Historial de Accesos**: Mantiene un registro de todos los accesos vehiculares, incluyendo fecha y hora.
- **Interfaz Intuitiva**: Diseñada para ser fácil de usar, con una navegación clara y accesible.

## Estructura y Navegación

### Página de Inicio
- **Logo**: Muestra el logo de la institución.
- **Botones de Navegación**: Acceso rápido a las funcionalidades principales como escaneo, registro de vehículos, lista de vehículos y registros de acceso.

### Escáner
- **Cámara para Escaneo**: Captura códigos QR en tiempo real.
- **Indicador de Procesamiento**: Muestra un indicador de carga mientras se procesan los datos.
- **Linterna**: Permite activar la linterna para mejorar la visibilidad en condiciones de poca luz.

### Resultado de Acceso
- **Icono de Resultado**: Indica si el acceso fue concedido o denegado.
- **Información del Vehículo**: Muestra detalles del vehículo si el acceso es concedido.
- **Botones de Acción**: Permite escanear nuevamente o regresar a la pantalla principal.

### Registro de Vehículo
- **Formulario de Registro**: Campos para ingresar información del vehículo y propietario.
- **Validaciones**: Asegura que los datos ingresados sean correctos y completos.
- **Alertas Personalizadas**: Muestra mensajes de éxito o error al registrar el vehículo.

### Vehículos Registrados
- **Barra de Búsqueda**: Filtra vehículos por número de placa o nombre del propietario.
- **Lista de Vehículos**: Muestra detalles de cada vehículo registrado.
- **Navegación a Detalles**: Permite acceder a la pantalla de detalles del vehículo.

### Accesos Registrados
- **Lista de Registros de Acceso**: Muestra un historial de todos los accesos vehiculares.

## Tecnologías Utilizadas

- **Frontend y Backend**: Flutter
- **Lenguaje de Programación**: Dart
- **Herramientas de Desarrollo**:
  - **Editor de Código**: Visual Studio Code
  - **Gestión de Paquetes**: Pub
  - **Control de Versiones**: Git y GitHub

## Manual de Usuario

### Inicio de Sesión
- **Usuario Administrador**:
  - Usuario: `admin`
  - Contraseña: `admin123`
- **Usuario Vigilante**:
  - Usuario: `vigilante`
  - Contraseña: `vigilante123`

### Página de Inicio
- **Vigilante**: Acceso a escáner, lista de vehículos y registros de acceso.
- **Administrador**: Acceso a escáner, registro de vehículos, registro de operadores, lista de vehículos y registros de acceso.

### Escaneo de Códigos QR
1. Presione el botón "Escanear" en la página de inicio.
2. Apunte la cámara hacia el código QR en el parabrisas del vehículo.
3. La aplicación procesará el código y mostrará el resultado del acceso.

### Registro de Vehículos (Solo Administrador)
1. Presione el botón "Registrar Vehículo".
2. Complete el formulario con los datos del vehículo y propietario.
3. Presione "Registrar Vehículo" para guardar la información.

### Registro de Operadores (Solo Administrador)
1. Presione el botón "Registrar Operador".
2. Complete el formulario con los datos del operador.
3. Presione "Registrar Usuario" para guardar la información.

### Detalles del Vehículo
- Acceda a la lista de vehículos y seleccione un vehículo para ver sus detalles.

### Accesos Registrados
- Acceda a la sección "Accesos Registrados" para revisar el historial de accesos vehiculares.


## Licencia

Este proyecto está bajo la licencia MIT. Para más detalles, consulta el archivo [LICENSE](LICENSE).

## Contacto

Si tienes alguna pregunta o sugerencia, no dudes en contactarnos:

- **Email**: soporte@qarapp.com
- **Sitio Web**: [www.qarapp.com](http://www.qarapp.com)

---

**Qar App** - Simplificando el control de acceso vehicular.
