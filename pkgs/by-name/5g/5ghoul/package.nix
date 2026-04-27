{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  clang,
  zstd,
  psmisc,
  sshpass,
  pkg-config,
  glib,
  freetype,
  flex,
  bison,
  libx11,
  libxrandr,
  libxinerama,
  libxcursor,
  libxi,
  boost,
}:

stdenv.mkDerivation rec {
  pname = "5ghoul";
  version = "0-unstable-2025-11-21";

  src = fetchFromGitHub {
    owner = "asset-group";
    repo = "5ghoul-5g-nr-attacks";
    rev = "master";
    sha256 = "sha256-mUGQhyY1k/Wph4DBuVK1AjrJNUTqaC2KhYWtPD6JQ8w=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    clang
    zstd
    psmisc
    sshpass
    pkg-config
    glib
    freetype
    flex
    bison
    libx11
    libxrandr
    libxinerama
    libxcursor
    libxi
    boost
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace clang++-15 clang++
    substituteInPlace CMakeLists.txt --replace clang-15 clang
  '';

  # TODO CMakeLists.txt tries to download boost if not found, see
  # https://github.com/asset-group/5ghoul-5g-nr-attacks/blob/452c8cedde810941e0bdd2dfac6da1b5079c42bf/CMakeLists.txt#L173-L198
  # Not sure how to properly set ${LIBBOOST_DOWNLOAD_DIR}/boost

  meta = {
    description = "Proof of Concept of 5G NR attacks against Qualcomm and Mediatek smartphones";
    homepage = "https://asset-group.github.io/disclosures/5ghoul/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ felbinger ];
  };
}
