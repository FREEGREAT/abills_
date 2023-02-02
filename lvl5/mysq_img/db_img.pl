#!C:\Strawberry\perl\bin\perl.exe
use strict;
use warnings;

use DBI;
use CGI;
use CGI::Carp qw/fatalsToBrowser/;
use File::Basename;

my $q = CGI->new;
print $q->header();
print $q->start_html();

my $host = "localhost";
my $port = "3306";
my $user = "root";
my $pass = "";
my $db = "qwerty";

my $conn = DBI->connect("DBI:mysql:$db:$host:$port", $user, $pass) or die "Connect error";


    print("Select action\n");
    my $action = <STDIN>;

    if($action == 1){
        insert_into();
    }elsif($action == 2){
        get_from_db();
    }else{
        print "Incorrect input!";
    }

    my $img_dir = 'C:\img';

    my $img_name = "pictures";

    sub insert_into{
        my $blob = 'C:\img\pic.jpeg';
        open (IMG, "+>> $blob");

        open(my $fh, $blob)||die "failed not open file $blob $!";
        my($img_data, $buff);
        while(read $fh, $buff,15360){
            $img_data .= $buff
        }

        my $stm = $conn->prepare("insert into img(data) values(?)");
        $stm->bind_param(1,$img_data,DBI::SQL_BLOB);
        $stm->execute;
        $fh->close;
    }

    sub get_from_db{
        my $stm = $conn->prepare("select * from img where id=48");
        $stm->execute;

        my $img_data = $stm->fetch;
        my $filename = "pic2.jpeg";

        open(my $fh, "> $filename")|| die "failed writing to file";

        print($fh @$img_data);

        $fh->close;
        $stm->finish;
        $conn->disconnect;


    }


print "Content-type:text/html\r\n\r\n";
$q->textfield(-name=>'Name', -default=>'Your name', -size=>32, -maxlength=>32);



