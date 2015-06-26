#!perl

use strict;
use warnings;

use Test::More;
use Test::Fatal;

BEGIN {
    use_ok('mop::role');
}

=pod

TODO:
- test how required methods are composed

=cut

{
    package Foo;
    use strict;
    use warnings;

    sub bar { 'BAR' }
    sub baz;
}

my $role = mop::role->new( name => 'Foo' );
isa_ok($role, 'mop::role');
# does_ok($role, 'mop::module'); # TODO
isa_ok($role, 'mop::object');

subtest '... testing setting a role that has required method' => sub {
    is($role->name, 'Foo', '... got the expected name');
    ok($role->is_abstract, '... the role is abstract');

    ok(!$role->requires_method('bar'), '... this method is not required');
    ok($role->requires_method('baz'), '... this method is required');
};

done_testing;
