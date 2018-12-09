with (import <nixpkgs> {});

let
  ruby = ruby_2_5;
  rubygems = (pkgs.rubygems.override { ruby = ruby; });
in mkShell {
  buildInputs = [
    ruby
    bundler
    rubocop
    solargraph
  ];

  shellHook = ''
    mkdir -p .nix-gems/bin
    export GEM_HOME=$PWD/.nix-gems
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
  '';
}
