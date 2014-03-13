package PRT::CLI;
use strict;
use warnings;

use Class::Load qw(load_class);
use Getopt::Long qw(GetOptionsFromArray);

sub new {
    my ($class) = @_;

    bless {}, $class;
}

sub parse {
    my ($self, @args) = @_;

    my $command = shift @args || 'help';

    my $command_class = $self->_command_name_to_command_class($command);
    load_class $command_class;
    $self->{command} = $command_class->new;

    my $collector_name = 'files';
    my $collector_class = $self->_collector_name_to_collector_class($collector_name);
    load_class $collector_class;

    $self->{collector} = $collector_class->new;
}

sub command {
    my ($self) = @_;

    $self->{command};
}

sub collector {
    my ($self) = @_;

    $self->{collector};
}

sub _command_name_to_command_class {
    my ($self, $name) = @_;

    my $command_class = join '', map { ucfirst } split '_', $name;

    'PRT::Command::' . $command_class;
}

sub _collector_name_to_collector_class {
    my ($self, $name) = @_;

    my $command_class = join '', map { ucfirst } split '_', $name;

    'PRT::Collector::' . $command_class;
}

1;