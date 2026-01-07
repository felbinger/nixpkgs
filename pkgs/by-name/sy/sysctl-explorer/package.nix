{
  lib,
  stdenv,
  fetchFromGitHub,
  jekyll,
  rubyPackages,
}:
stdenv.mkDerivation {
  pname = "sysctl-explorer";
  version = "0-unstable-2018-07-16";

  src = fetchFromGitHub {
    owner = "proudier";
    repo = "sysctl-explorer";
    rev = "18643a0ba7684ef6936c0b62fc9d6932beb45384";
    hash = "sha256-g3BcYcJY8KIZ+UvReQ97GlHRUkowgNMuHu4NfOZZmIM=";
  };

  nativeBuildInputs = [
    jekyll
  ] ++ (with rubyPackages; [
    jekyll-minifier
    jekyll-feed
    jekyll-sitemap
    jekyll-assets
    jekyll-algolia
  ]);

  buildPhase = ''
    jekyll build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';

  # no need to build on remote builder
  preferLocalBuild = true;

  meta = {
    description = "Easy access to Linux' sysctl documentation";
    homepage = "https://github.com/proudier/sysctl-explorer";
    platforms = lib.platforms.all;
  };
}
