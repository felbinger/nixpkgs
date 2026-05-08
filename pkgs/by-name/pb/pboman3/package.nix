{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  cmake,
  qt6,
  cli11,
  googletest
}:

stdenv.mkDerivation rec {
  pname = "pboman3";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "winseros";
    repo = "pboman3";
    rev = "v1.10.0";
    sha256 = "sha256-lAnYEMNJLPdkW1xi3KpjK8ydGQ+Iuht4D5yHMDI/3lk=";
  };

  patchPhase = ''
    substituteInPlace CMakeLists.txt \
      --replace "add_subdirectory(__lib__/cli11)" "" \
      --replace "add_subdirectory(__lib__/googletest)" ""
  '';

  nativeBuildInputs = [
    pkg-config
    cmake
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    cli11
    googletest
  ];

  meta = {
    description = "GUI tool to work with ArmA PBO files";
    homepage = "https://github.com/winseros/pboman3";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ felbinger ];
  };
}
