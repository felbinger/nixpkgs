{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  pkg-config,
  zlib,
}:

stdenv.mkDerivation {
  pname = "googletest";
  version = "1.17.0";

  src = fetchFromGitHub {
    owner = "google";
    repo = "googletest";
    tag = "v1.17.0";
    sha256 = "sha256-HIHMxAUR4bjmFLoltJeIAVSulVQ6kVuIT2Ku+lwAx/4=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
  ];

  buildInputs = [ zlib ];

  meta = {
    description = "Google Testing and Mocking Framework";
    homepage = "https://github.com/google/googletest";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ felbinger ];
    platforms = lib.platforms.unix;
  };
}
