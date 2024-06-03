# Add RVM to PATH for scripting.
export PATH="$PATH:$HOME/.rvm/bin"

# Set the openssl path for ruby installs
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"
