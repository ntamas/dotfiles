# Add ~/lib to the linker path
export DYLD_LIBRARY_PATH="$HOME/lib${DYLD_LIBRARY_PATH+:}${DYLD_LIBRARY_PATH}"

# Add ~/lib/pkgconfig to the pkg-config path
export PKG_CONFIG_PATH="$HOME/lib/pkgconfig${PKG_CONFIG_PATH+:}${PKG_CONFIG_PATH}"
