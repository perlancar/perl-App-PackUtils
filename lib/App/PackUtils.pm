package App::PackUtils;

# DATE
# VERSION

use strict;
use warnings;

our %SPEC;

$SPEC{perl_pack} = {
    v => 1.1,
    summary => 'Pack() data',
    args => {
        template => {
            schema => 'str*',
            req => 1,
            pos => 0,
        },
        data => {
            schema => 'array*',
            req => 1,
            pos => 1,
            greedy => 1
        },
    },
    'cmdline.default_format' => 'perl',
    result_naked => 1,
};
sub perl_pack {
    my %args = @_;

    pack($args{template}, @{ $args{data} });
}

$SPEC{perl_unpack} = {
    v => 1.1,
    summary => 'Unpack() string',
    args => {
        template => {
            schema => 'str*',
            req => 1,
            pos => 0,
        },
        string => {
            schema => 'str*',
            pos => 1,
        },
        escaped_string => {
            schema => 'str*',
            cmdline_aliases => {e=>{}},
        },
    },
    args_rels => {
        req_one => ['string', 'escaped_string'],
    },
    'cmdline.default_format' => 'perl',
    result_naked => 1,
};
sub perl_unpack {
    my %args = @_;

    [unpack($args{template}, @{ exists $args{string} ? $args{string} : eval($args{escaped_string}) })];
}

1;
# ABSTRACT: Command-line utilities related to Perl pack() and unpack()

=head1 SYNOPSIS

This distribution provides tha following command-line utilities related to Perl
C<pack()> and C<unpack()> functions:

#INSERT_EXECS_LIST

=cut
