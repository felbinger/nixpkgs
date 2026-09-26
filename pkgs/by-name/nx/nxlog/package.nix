{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  writeScript,
  curl,
  jq,
  common-updater-scripts,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "nxlog-ce";
  version = "3.2.2329";

  /*
  Download url needs to be requested with CSRF token... Too complicated I guess
  curl 'https://nxlog.co/downloads' \
    -X POST \
    -H 'X-CSRF-TOKEN: nBGvQQZ8zDdSYRtr4dYtluJDwil1ff3OZsx9zKwN' \
    -H 'Cookie: XSRF-TOKEN=eyJpdiI6InFKWW45YmFBbGUyL0toUks3bm5JZEE9PSIsInZhbHVlIjoiYU8vcWxZakM1ODVSc2t4c0F3VU1XK0NtSTVqMU5oOHRLUCt0aHFwNW93dXZhRXpTTmFlb0FKdjR2OElHQVBnZm9zdXpDT3d1TUVnL0tUSG4xc3FTRnFJTXV6TzJ3QTFsTWRQWGdiK3Z1RlZwWEJOcVJ1MkJCMWZldFRjeTlVRmgiLCJtYWMiOiJmOWNjZGEzMjA0NTlkMDA1MjRlMDBlNGFiNmY1OWVhMGM3MzViMWFiYThhMGFkOWNmNjdlOTBjMzg4MDc3YzRjIiwidGFnIjoiIn0%3D; nxlbackoffice_session=eyJpdiI6IjVQQVdVR0E1L2txa2l2azUvMTU1amc9PSIsInZhbHVlIjoiSkZKaHNYdHpiRXpLbGRNSEJWeEtJMWdqNVFrajRnQ1RoWkFTMEUyZ0RUbU92STZkVWg1NFEyc1FBQ0pwcXhhSEUxdkJ3dFFIaEY4cGRYL1J0MGhTanNkYkJwRDRqeE1WU21TaHFZd1E0SXgwN1U3R1FHUHR2NTF0VlhJMm0vcXQiLCJtYWMiOiJiMzc4MWQ0YzE3MTUyNTU1MDcyMmZmYjg5MmU1N2NhNDg3ZTBiNTA2YzI3MTBiNjhlMTA4YmY2ZTRjNTllMjY1IiwidGFnIjoiIn0%3D' \
    -H 'Content-Type: application/json' \
    --data-raw '{"file_id":"829"}'
  */

  src = fetchurl {
    url = "https://dl.nxlog.co/dl/6ab7fdb8ccd02";
    hash = "sha256-yk9bck9XKDZDhsiYiMECCKgxzAYx4LoOUA6G02s1sfc=";
  };

  unpackPhase = ''
    dpkg-deb -x $src $out
  '';

  nativeBuildInputs = [ dpkg ];

  # resulting binaries are not executeable, consider putting this in fhs

  meta = {
    description = "High-performance log collector";
    changelog = "https://dl.nxlog.co/dl/6ab7feb2bf92f";
    homepage = "https://nxlog.co";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ felbinger ];
  };
})
