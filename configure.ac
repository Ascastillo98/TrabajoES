AC_INIT([mi_proyecto], [1.0], [mi_correo@dominio.com])
AC_CONFIG_SRCDIR([main.c])
AC_CONFIG_HEADERS([config.h])

# Verificar dependencias
AC_CHECK_LIB([m], [sin])

# Configuración de opciones
AC_ARG_ENABLE([debug],
  [AS_HELP_STRING([--enable-debug], [Habilitar la información de depuración])],
  [enable_debug=yes],
  [enable_debug=no])

AM_INIT_AUTOMAKE

# Salida del script de configuración
AC_OUTPUT(Makefile)
