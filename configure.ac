AC_INIT([TrabajoES], [1.0], [ascastillo1998@gmail.com])
AC_CONFIG_SRCDIR([main.cpp])
AC_CONFIG_HEADERS([config.h])

AC_CONFIG_FILES([Makefile])
# Verificar dependencias
AC_CHECK_LIB([m], [sin])

# Configuración de opciones
AC_ARG_ENABLE([debug],
  [AS_HELP_STRING([--enable-debug], [Habilitar la información de depuración])],
  [enable_debug=yes],
  [enable_debug=no])

AM_INIT_AUTOMAKE

# Salida del script de configuración
AC_OUTPUT()
