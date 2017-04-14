source ~/perl5/perlbrew/etc/bashrc
source ~/.bashrc

export PERL_CPANM_OPT=' --mirror http://mirror.cc.columbia.edu/pub/software/cpan/ --mirror http://cpan.cse.msu.edu/ --mirror http://www.cpan.org/ --mirror http://cpan.perlnow.com/ --mirror http://cpan.mirror.facebook.net/ --mirror-only --cascade-search'

alias l='ls -la'

alias dzil_make_dist='perl ~/.dzil/add_to_dist.pl'

if [ -z $PS1 ]
then
    #null op
    true
else
	echo ""
	echo "Commands preinstalled with perl-5.16.3 are:"
	echo "  perlbrew - manage Perl versions. See perlbrew help"
	echo "  cpanm - easy way to install of Perl modules as nonroot"
	echo "  pm_which - gives info about a module, e.g. pm_which -V Module::Util."
	echo "  perltidy - cleans code. Mapped to F4 key in vim."
	echo "  countperl - provides code metrics, e.g. countperl \`pm Module::Util\`."
	echo "  perlcritic - criticise your code for free!, e.g. perlcritic Module::Util"
	echo "  dzil - Perl package maker. e.g. dzil new Your::New::Module"
	echo "         You can also use 'dzil_make_dist' command add common dzil configs to dist.ini"
	echo "  pinto - listing modules available in our Pinto. See pinto help"
	echo
	echo "You can disable this friendly summary by editing ~/.bash_profile"
	echo ""
fi
true
