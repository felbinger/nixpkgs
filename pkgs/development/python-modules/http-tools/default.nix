{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  mitmproxy,
  markupsafe,
}:

buildPythonPackage (finalAttrs: {
  pname = "http-tools";
  version = "5.0.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "MobSF";
    repo = "httptools";
    tag = finalAttrs.version;
    hash = "sha256-TmAhxdMgqRtA4j269IqYl23BQCuNSR/mi07WVmkjfZU=";
  };

  build-system = [ setuptools ];

  dependencies = [
    mitmproxy
    markupsafe
  ];

  pythonRelaxDeps = [
    "mitmproxy"
  ];

  pythonImportsCheck = [ "http_tools" ];

  meta = {
    description = "httptools helps you to capture, repeat and live intercept HTTP requests with scripting capabilities. It is built on top of mitmproxy";
    homepage = "https://github.com/MobSF/httptools";
    changelog = "https://github.com/MobSF/httptools/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.lgpl21;
    maintainers = with lib.maintainers; [ felbinger ];
  };
})
