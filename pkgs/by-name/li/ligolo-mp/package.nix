{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  pkgsCross ? { },
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  pname = "ligolo-mp";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "ttpreport";
    repo = "ligolo-mp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-oMJnGpcFNwVlvO0GHQrSA4xyvhZ6SBaGwo+eR5GDybM=";
  };

  vendorHash = null;

  env.CGO_ENABLED = 0;

  subPackages = [
    "cmd/client"
    "cmd/server"
  ];

  ldflags = [
    "-s"
    "-w"
    "-extldflags '-static'"
    "-X main.version=${finalAttrs.version}"
  ];

  # This will prefix all the binaries with ligolo-
  #postInstall = ''
  #  for f in $out/bin/*; do
  #    mv "$f" "$(dirname "$f")/ligolo-$(basename "$f")"
  #  done
  #'';

  #nativeInstallCheckInputs = [ versionCheckHook ];
  #versionCheckProgram = "${placeholder "out"}/bin/ligolo-client";
  #doInstallCheck = true;

  #passthru = {
  #  tests = {
  #    win = pkgsCross.mingwW64.ligolo-ng or null;
  #    linux64 = pkgsCross.gnu64.ligolo-ng or null;
  #  };
  #  updateScript = nix-update-script { };
  #};

  # Tests require network access
  #doCheck = false;

  meta = {
    description = "Multiplayer pivoting solution";
    homepage = "https://github.com/ttpreport/ligolo-mp";
    changelog = "https://github.com/ttpreport/ligolo-mp/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ felbinger ];
    platforms = lib.platforms.linux ++ lib.platforms.windows;
  };
})
