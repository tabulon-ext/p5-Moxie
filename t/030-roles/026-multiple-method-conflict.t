#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;



package R1 {
    use Moxie;

    sub foo { 1 }
}

package R2 {
    use Moxie;

    sub foo { 1 }
}

package R3 {
    use Moxie;

    sub foo { 1 }
}

package R4 {
    use Moxie;

    sub foo { 1 }
}

package R5 {
    use Moxie;

    sub foo { 1 }
}

BEGIN {
    local $@ = undef;
    eval q[
        package C1 {
            use Moxie;

            extends 'Moxie::Object';
               with 'R1';
        }
    ];
    ok(!$@, '... no exception, C1 does R1');
}

BEGIN {
    local $@ = undef;
    eval q[
        package C2 {
            use Moxie;

            extends 'Moxie::Object';
               with 'R1', 'R2';
        }
    ];
    like(
        "$@",
        qr/^\[CONFLICT\] There should be no conflicting methods when composing \(R1, R2\) into \(C2\) but instead we found \(foo\)/,
        '... got an exception, C2 does R1, R2'
    );
}

BEGIN {
    local $@ = undef;
    eval q[
        package C3 {
            use Moxie;

            extends 'Moxie::Object';
               with 'R1', 'R2', 'R3';
        }
    ];
    like(
        "$@",
        qr/^\[CONFLICT\] There should be no conflicting methods when composing \(R1, R2, R3\) into \(C3\) but instead we found \(foo\)/,
        '... got an exception, C3 does R1, R2, R3'
    );
}

BEGIN {
    local $@ = undef;
    eval q[
        package C4 {
            use Moxie;

            extends 'Moxie::Object';
               with 'R1', 'R2', 'R3', 'R4';
        }
    ];
    like(
        "$@",
        qr/^\[CONFLICT\] There should be no conflicting methods when composing \(R1, R2, R3, R4\) into \(C4\) but instead we found \(foo\)/,
        '... got an exception, C4 does R1, R2, R3, R4'
    );
}

BEGIN {
    local $@ = undef;
    eval q[
        package C5 {
            use Moxie;

            extends 'Moxie::Object';
               with 'R1', 'R2', 'R3', 'R4', 'R5';
        }
    ];
    like(
        "$@",
        qr/^\[CONFLICT\] There should be no conflicting methods when composing \(R1, R2, R3, R4, R5\) into \(C5\) but instead we found \(foo\)/,
        '... got an exception, C5 does R1, R2, R3, R4, R5'
    );
}

package R1_required {
    use Moxie;

    sub foo;
}

BEGIN {
    local $@ = undef;
    eval q[
        package C1_required {
            use Moxie;

            extends 'Moxie::Object';
               with 'R1_required', 'R2';
        }
    ];
    ok(!$@, '... no exception, C1 does R1');
}

done_testing;
