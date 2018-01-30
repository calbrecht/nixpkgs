{ stdenv, fetchgit, cmake, SDL2, qtbase, boost, curl, gtest }:

stdenv.mkDerivation rec { 
  name = "citra-2018-01-24";

  # Submodules
  src = fetchgit {
    url = "https://github.com/citra-emu/citra";
    rev = "33b0b5163fdb08bc8aa1d7eb83e0931a14ed3046";
    sha256 = "07z32d8lj84yy3l5iqpk37mnmvzjmppqhyqr64kbx14dh5hb6cbj";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ SDL2 qtbase boost curl gtest ];
  cmakeFlags = [ "-DUSE_SYSTEM_CURL=ON" "-DUSE_SYSTEM_GTEST=ON" ];

  preConfigure = ''
    # Trick configure system.
    sed -n 's,^ *path = \(.*\),\1,p' .gitmodules | while read path; do
      mkdir "$path/.git"
    done
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = https://citra-emu.org/;
    description = "An open-source emulator for the Nintendo 3DS capable of playing many of your favorite games.";
    platforms = platforms.linux;
    license = licenses.gpl2;
    maintainers = with maintainers; [ abbradar ];
  };
}
