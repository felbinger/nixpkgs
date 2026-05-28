{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  poetry-core,
  poetry-dynamic-versioning,
  gitMinimal,

  # dependencies
  kombu,
  lastversion,
  lxml,
  meshtastic,
  pika,
  poetry,
  protobuf,
  psutil,
  psycopg,
  pyopenssl,
  pyfiglet,
  pygc,
  pyotp,
  pytak,
  python-ffmpeg,
  python-socketio,
  semver,
  simplekml,
  sqlalchemy,
  sqlalchemy-utils,
  tldextract,
  #unishox2-py3, # needs to be packaged
  yt-dlp,
  zope-event,
  zope-interface,
  flask-cors,
  flask-ldap3-login,
  flask-mailman,
  flask-migrate,
  flask-socketio,
  flask-sqlalchemy,
  eventlet,
  flask-apscheduler,
  flask-babel,
  dulwich,
  httpx,
  datetime,
  flask-security,
  pyjwt,
  adsbcot,
  aiscot,
  androguard,
  colorlog,

  pytestCheckHook,
}:

buildPythonPackage (finalAttrs: {
  pname = "opentakserver";
  version = "1.7.13";
  pyproject = true;
  __structuredAttrs = true;

  # fetchFromGitHub removes .git...
  src = fetchFromGitHub {
    owner = "brian7704";
    repo = "OpenTAKServer";
    tag = finalAttrs.version;
    hash = "sha256-nzfFAY3Sihz5gDtgOjZGKwtITGV/06d46tHR0u9Xrus=";
    leaveDotGit = true;
  };

  build-system = [
    poetry-core
    poetry-dynamic-versioning # TODO use env vars to remove need for .git # https://pypi.org/project/poetry-dynamic-versioning/#:~:text=POETRY_DYNAMIC_VERSIONING_BYPASS%3A%20Use%20this,the%20original%20repository
    gitMinimal
  ];

  pythonRemoveDeps = [
    "adsbxcot" # replaced by adsbcot
  ];

  pythonRelaxDeps = [
    "aiscot"
    "beautifulsoup4"
    "datetime"
    "dulwich"
    "flask-babel"
    "flask-cors"
    "flask-socketio"
    "flask-ldap3-login"
    "gevent"
    "kombu"
    "poetry"
    "protobuf"
    "psutil"
    "psycopg"
    "pyopenssl"
    "pyfiglet"
    "pytak"
    "pyjwt"
    "python-socketio"
    "sqlalchemy"
    "sqlalchemy-utils"
    "tldextract"
    "zope-event"
    "zope-interface"
  ];

  dependencies = [
    kombu
    lastversion
    lxml
    meshtastic
    pika
    poetry
    protobuf
    psutil
    psycopg
    pyopenssl
    pyfiglet
    pygc
    pyotp
    pytak
    python-ffmpeg
    python-socketio
    semver
    simplekml
    sqlalchemy
    sqlalchemy-utils
    tldextract
    #unishox2-py3
    yt-dlp
    zope-event
    zope-interface
    flask-cors
    flask-ldap3-login
    flask-mailman
    flask-migrate
    flask-socketio
    flask-sqlalchemy
    eventlet
    flask-apscheduler
    flask-babel
    dulwich
    httpx
    datetime
    flask-security
    pyjwt
    adsbcot
    aiscot
    androguard
    colorlog
  ];

  pythonImportsCheck = [ "OpenTAKServer" ];

  meta = {
    description = "TAK Server for ATAK, iTAK, and WinTAK";
    homepage = "https://opentakserver.io/";
    changelog = "https://github.com/brian7704/OpenTAKServer/releases/tag/${finalAttrs.version}";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ felbinger ];
  };
})
