{ stdenv, lib, fetchFromGitHub, cmake, fetchpatch }:

stdenv.mkDerivation rec {
  pname = "libdispatch";
  version = "5.5";

  src = fetchFromGitHub {
    owner = "apple";
    repo = "swift-corelibs-libdispatch";
    rev = "swift-${version}-RELEASE";
    hash = "sha256-MbLgmS6qRSRT+2dGqbYTNb5MTM4Wz/grDXFk1kup+jk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [ "-DCMAKE_INSTALL_LIBDIR=lib" ];

  patches = [ (fetchpatch {
    url = "https://github.com/apple/swift-corelibs-libdispatch/commit/729e25d92d05a8c4a8136e831ec6123bbf7f2654.diff";
    hash = "sha256-uOtdPHRYPYTwHuKoYqup8f/yWrqF97pM3pudhGgMNk4=";
  }) 
  # https://github.com/apple/swift-corelibs-libdispatch/commit/915f25141a7c57b6a2a3bc8697572644af181ec5
  ./unused-variable-spins.patch
 ];


  meta = with lib; {
    description = "The libdispatch Project, (a.k.a. Grand Central Dispatch), for concurrency on multicore hardware";
    homepage = "http://swift.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ hmelder ];
    platforms = platforms.unix;
  };
}
