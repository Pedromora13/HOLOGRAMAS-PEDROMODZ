#!/system/bin/sh

# ==========================================
# ⚡ PedroModz666 - Panel Hologramas ⚡
# ==========================================

# --- CONFIGURACIÓN DE ACTUALIZACIÓN ONLINE ---
VERSION_ACTUAL="1.1"
CURL_PATH="/data/data/com.termux/files/usr/bin/curl"
URL_VERSION="https://raw.githubusercontent.com/Pedromora13/HOLOGRAMAS-PEDROMODZ/main/version.txt"
URL_SCRIPT="https://raw.githubusercontent.com/Pedromora13/HOLOGRAMAS-PEDROMODZ/main/PedroModz666.sh"

# Configuración del juego
PACKAGE="com.dts.freefireth"
FILE="/data/user/0/com.dts.freefireth/files/split_asset_pack_install_time.apk.pdcache"
URL_DESCARGA="https://www.mediafire.com/file/kniqz28gb69dcrb/Free+Fire_1.132.1.apks/file"
SCRIPT_PATH="$0"

# 1. Verificación de actualización del script en línea
verificar_actualizacion() {
    if [ -x "$CURL_PATH" ]; then
        VERSION_REMOTA=$("$CURL_PATH" -s "$URL_VERSION" | tr -d '\r' | tr -d '\n' | xargs)
        
        if [ -n "$VERSION_REMOTA" ] && [ "$VERSION_ACTUAL" != "$VERSION_REMOTA" ]; then
            printf "\n\033[1;31m¡Nueva actualización disponible ($VERSION_REMOTA)!\033[0m\n"
            printf "¿Deseas actualizar ahora? (s/n): "
            read respuesta
            if [ "$respuesta" = "s" ] || [ "$respuesta" = "S" ]; then
                printf "Actualizando script...\n"
                if "$CURL_PATH" -s -o "$0" "$URL_SCRIPT"; then
                    chmod +x "$0"
                    printf "\033[1;32mActualización completada! Vuelve a abrir el script.\033[0m\n"
                    exit 0
                else
                    printf "\033[1;31mError al descargar la actualización.\033[0m\n"
                fi
            fi
        fi
    fi
}

# Ejecutar verificación de actualización primero
verificar_actualizacion

clear
echo "=========================================="
echo "⚡         PEDROMODZ666 - VERIFICANDO         ⚡"
echo "=========================================="

if ! pm list packages | grep -q "$PACKAGE"; then
    echo "❌ ERROR: Free Fire no está instalado."
    echo "⚠️ Redirigiendo a la descarga de la APK..."
    sleep 2
    am start -a android.intent.action.VIEW -d "$URL_DESCARGA" >/dev/null 2>&1
    exit 1
else
    echo "✅ Free Fire detectado correctamente."
fi

# 3. Verificación automática de la existencia del archivo de modificación
if [ ! -f "$FILE" ]; then
    echo "=========================================="
    echo "❌ ERROR: Fichero no Generado en el dispositivo"
    echo "⚠️ ABRE EL JUEGO DOS VECES"
    echo "=========================================="
    exit 1
else
    echo "✅ Fichero de datos localizado con éxito."
fi

sleep 1

# 4. Menú Principal de Hologramas
clear
echo "=========================================="
echo "⚡         PEDROMODZ666 HOLOGRAMAS        ⚡"
echo "=========================================="
echo "1) Holograma Wukong"
echo "2) Holograma Personaje"
echo "3) Descargar APK"
echo "4) Salir"
echo "=========================================="
printf "Selecciona una opción [1-4]: "
read OPCION

cerrar_juego() {
    if pidof "$PACKAGE" >/dev/null 2>&1; then
        echo "⚠️ Cerrando Free Fireth para aplicar cambios..."
        am force-stop "$PACKAGE"
        sleep 1
    fi
}

case $OPCION in
    1)
        cerrar_juego
        echo "🔍 Procesando Holograma Wukong..."
        sed '
        s/c2fe8cab7a89d9f4c84380854f97bbe5/TEMP_MARK_WUKONG/g
        s/c8a0a7e7d90b9dc4abeb5dbdce044e86/c2fe8cab7a89d9f4c84380854f97bbe5/g
        s/TEMP_MARK_WUKONG/c8a0a7e7d90b9dc4abeb5dbdce044e86/g
        ' "$FILE" > "${FILE}.tmp" && mv "${FILE}.tmp" "$FILE"
        
        echo "=========================================="
        echo "🔥 ⚡ HOLOGRAMA WUKONG LISTO A JUGAR ⚡ 🔥"
        echo "=========================================="
        
        # Autodestrucción del script
        sleep 1
        rm -f "$SCRIPT_PATH"
        ;;
    2)
        cerrar_juego
        echo "🔍 Procesando Holograma Rojo..."
        sed '
        s/3bfa57c4e073a09479db0c47d8bd84d8/TEMP_MARK_RED/g
        s/216a7113b7f1bc74eb2289d47f2a406d/3bfa57c4e073a09479db0c47d8bd84d8/g
        s/TEMP_MARK_RED/216a7113b7f1bc74eb2289d47f2a406d/g
        ' "$FILE" > "${FILE}.tmp" && mv "${FILE}.tmp" "$FILE"
        
        echo "=========================================="
        echo "🔥 ⚡ HOLOGRAMA ROJO LISTO A JUGAR ⚡ 🔥"
        echo "=========================================="
        
        # Autodestrucción del script
        sleep 1
        rm -f "$SCRIPT_PATH"
        ;;
    3)
        echo "🌐 Abriendo navegador para descargar..."
        am start -a android.intent.action.VIEW -d "$URL_DESCARGA" >/dev/null 2>&1
        ;;
    4)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "❌ Opción inválida."
        exit 1
        ;;
esac
