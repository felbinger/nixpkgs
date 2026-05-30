{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  rustPlatform,
}:
let
  pname = "rayhunter";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "EFForg";
    repo = "rayhunter";
    tag = "v${version}";
    hash = "sha256-C/EIgmgIxLonVr2/9oTCuGz6+AUBPeiExWoEzuKDxB0=";
  };

  frontend = buildNpmPackage (finalAttrs: {
    pname = "${pname}-frontend";
    inherit version;
    src = "${src}/daemon/web";

    npmDepsHash = "sha256-z+g+arRzthX43G4GlPtZPQ/2/DO3yHIxGuIMUFPE+ws=";

    npmPackFlags = [ "--ignore-scripts" ];
  });

  daemon = rustPlatform.buildRustPackage (finalAttrs: {
    pname = "${pname}-daemon";
    inherit version src;
    sourceRoot = "${src.name}/daemon";

    prePatch = ''
      cp -v ${src}/Cargo.lock .
    '';

    # TODO how to cross compile?

    cargoHash = "sha256-VqgMeAt7l0MJiy5rUghLyzbmCx1eAOKZQIF1TGzKK2c=";
  });
in
rustPlatform.buildRustPackage (finalAttrs: {
  inherit pname version src;

  # TODO how to cross compile

  cargoHash = "sha256-VqgMeAt7l0MJiy5rUghLyzbmCx1eAOKZQIF1TGzKK2c=";

  meta = {
    description = "Rust tool to detect cell site simulators on an orbic mobile hotspot";
    homepage = "efforg.github.io/rayhunter/";
    changelog = "https://github.com/EFForg/rayhunter/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ felbinger ];
  };
})
