# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null) && ! $(brew --prefix &>/dev/null)
then
  source `brew --prefix`/etc/grc.zsh
fi
