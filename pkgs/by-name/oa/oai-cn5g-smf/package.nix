{
  lib,
  stdenv,
  fetchFromGitHub,
  asio,
  boost,
  # libasan6,
  curl,
  libevent,
  # libgmp-dev,
  # libhogweed,
  openssl,
  libtool,
  libxml2,
  nettle,
  net-tools,
  pkg-config,
  ninja,
  cmake,
  gitMinimal,
  libcpr,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "oai-cn5g-smf";
  version = "2.2.1";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "openairinterface";
    repo = "oai-cn5g-smf";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/UrOmuSXXd/OfWZ3dIPKqd3PdrbhwFBaYVLozHKtXiE=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    asio
    boost
    # libasan6
    curl
    libevent
    # libgmp-dev
    # libhogweed
    openssl
    libtool
    libxml2
    nettle
    net-tools
    pkg-config
    ninja
    cmake
    gitMinimal
    libcpr
  ];

  configurePhase = ''
    cd build/smf
    cmake . -DCMAKE_POLICY_VERSION_MINIMUM=3.5
  '';

  dontUseCmakeConfigure = true;

  meta = {
    description = "OAI 5G Core Network Session Management Function (SMF)";
    homepage = "https://openairinterface.org/core-network/";
    changelog = "https://github.com/openairinterface/oai-cn5g-smf/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = with lib.licenses; [
      oai-cssl
      mit
      cc-by-40
    ];
    maintainers = with lib.maintainers; [ felbinger ];
  };
})
