{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pytestCheckHook,

  # dependencies
  setuptools-scm,
  numpy,
  pyproj,
}:

buildPythonPackage (finalAttrs: {
  pname = "pygc";
  version = "2.0.0";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "axiom-data-science";
    repo = "pygc";
    tag = finalAttrs.version;
    hash = "sha256-hXeZWnL0z2DC5FWUxSPBb5JmiKd1i3sSoM4FZq0mL7M=";
  };

  build-system = [ setuptools ];

  dependencies = [
    setuptools-scm
    numpy
    pyproj
  ];

  # require internet access
  doChecks = false;

  pythonImportsCheck = [ "pygc" ];

  meta = {
    description = "Great Circle calculations for Python 2/3 using Vincenty's formulae";
    homepage = "https://github.com/axiom-data-science/pygc";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ felbinger ];
  };
})
