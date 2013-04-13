# Installs the moxi proxy

class moxi::install {
  package { 'moxi-server':
    ensure  => 'present',
  }
}
