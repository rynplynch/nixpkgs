{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  layer-shell-qt,
  lxqt-build-tools,
  qtbase,
  qtermwidget,
  qttools,
  qtwayland,
  wrapQtAppsHook,
  gitUpdater,
  nixosTests,
}:

stdenv.mkDerivation rec {
  pname = "qterminal";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "lxqt";
    repo = pname;
    rev = version;
    hash = "sha256-H1UmPIZG8KiVNPW3GqgnSq39JsZeowiAVwwEKwCkWoM=";
  };

  nativeBuildInputs = [
    cmake
    lxqt-build-tools
    qttools
    wrapQtAppsHook
  ];

  buildInputs = [
    layer-shell-qt
    qtbase
    qtermwidget
    qtwayland
  ];

  passthru.updateScript = gitUpdater { };

  passthru.tests.test = nixosTests.terminal-emulators.qterminal;

  meta = with lib; {
    homepage = "https://github.com/lxqt/qterminal";
    description = "Lightweight Qt-based terminal emulator";
    mainProgram = "qterminal";
    license = licenses.gpl2Plus;
    platforms = with platforms; unix;
    teams = [ teams.lxqt ];
  };
}
