pkgname="sleex-welcome-screen"
pkgver="1.0"
pkgrel="1"
pkgdesc="Welcome screen and interactive tutorial for Sleex desktop environment"
arch=("x86_64")
depends=(
  "qt6-base" "qt6-declarative" "qt6-wayland" "layer-shell-qt" "sleex-ui-kit"
)
makedepends=("cmake")
optdepends=(
  "sleex: Sleex desktop environment"
  "hyprland: Wayland compositor"
)

build() {
  rm -rf build/
  cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
  cmake --build build -j$(nproc --ignore=2)
}

package() {
  DESTDIR="$pkgdir" cmake --install build
}
