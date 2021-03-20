<?php
$username="root";//change username 
$password=""; //change password
$host="localhost";
$db_name="id16282576_flutter_db"; //change databasename

$connect=mysqli_connect($host,$username,$password,$db_name);

if($connect->connect_error)
{
	die("Connection Failed: ".$connect->connect_error);
}

?>