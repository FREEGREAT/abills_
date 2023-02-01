#!C:\Strawberry\perl\bin\perl.exe

use strict;
use warnings;

use CGI;
use CGI::Carp qw/fatalsToBrowser/;
use File::Basename;
use DBI;

my $q = CGI->new;
print $q->header();
print $q->start_html();

my $host = "localhost";
my $port = "3306";
my $user = "root";
my $pass = "";
my $db = "qwerty";

print "Content-type: text/html\n\n";
while(1){
    print("Select action\n");
    my $action = <STDIN>;

    if($action == 1){
        input_data($db,$host,$port,$user,$pass);
    }elsif($action == 2){
        delete_row($db,$host,$port,$user,$pass);
    }elsif($action == 3){
        show_record($db,$host,$port,$user,$pass);
    }elsif($action == 4){
        last();
    }else{
        print "Incorrect input!";
    }

    sub input_data{
        my ($db,$host,$port,$user,$pass) = (shift,shift,shift,shift,shift);
        my $conn = DBI->connect("DBI:mysql:$db:$host:$port", $user, $pass) or die "Connect error";

        print("Input ID: ");
        chomp(my $id = <STDIN>);
        print ( $id " hi");
        print("Input Name: ");
        chomp(my $name = <STDIN>);
        print("Input Surname: ");
        chomp(my $surname = <STDIN>);
        print("Input Age: ");
        chomp (my $age = <STDIN>);

        my $sth = $conn->prepare("insert into table1(ID,Name,Surname,Age) values(?,?,?,?)");
        $sth ->execute($id,$name,$surname,$age);
        my $rc = $sth ->finish;
        $rc = $conn -> disconnect;
        return 1;
    };

    sub delete_row{
        my ($db,$host,$port,$user,$pass) = (shift,shift,shift,shift,shift);
        my $conn = DBI->connect("DBI:mysql:$db:$host:$port", $user, $pass) or die "Connect error";
        print("Input ID:");
        chomp( my $id = <STDIN>);
        print("This row was delete: \n");
        my $sth = $conn->prepare("select * from table1 where ID=?");
        $sth ->execute($id);
        while (my @row = $sth->fetchrow_array()){
            print join ("\t", @row)."\n";
        }
       my $sth = $conn ->prepare("delete from table1 where ID=?");
        $sth ->execute($id);
        my $rc = $sth ->finish;
        $rc = $conn -> disconnect;
    };

    sub show_record{
        my ($db,$host,$port,$user,$pass) = (shift,shift,shift,shift,shift);
        my $conn = DBI->connect("DBI:mysql:$db:$host:$port", $user, $pass) or die "Connect error";
        my $sth = $conn->prepare("select * from table1");
        $sth ->execute;
        while (my @row = $sth->fetchrow_array()){
            print join ("\t", @row)."\n";
        }
        my $rc = $sth ->finish;
        $rc = $conn -> disconnect;

    }

    sub insert_image{
        my ($db,$host,$port,$user,$pass) = (shift,shift,shift,shift,shift);
        my $dir = "";
        my $conn = DBI->connect("DBI:mysql:$db:$host:$port", $user, $pass) or die "Connect error";
        my $sth = $conn->prepare("insert into image(image) values(?)");
        $sth ->execute;
        while (my @row = $sth->fetchrow_array()){
            print join ("\t", @row)."\n";
        }
        my $rc = $sth ->finish;
        $rc = $conn -> disconnect;
    }
};
