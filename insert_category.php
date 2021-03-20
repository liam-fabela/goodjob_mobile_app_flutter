<?php
include "config.php";

$json = file_get_contents('php://input');
$obj = json_decode($json,true);
$id = $obj["id"];
$cat = $obj["cat"];
$cat2= $obj["cat2"];
$cat3 = $obj["cat3"];
$cat4= $obj["cat4"];
//$searchPassword = $_GET["searchPassword"];
$a= array();

if(!(empty($cat))){
     array_push($a,$cat);
}

if(!(empty($cat2))){
     array_push($a,$cat2);
}

if(!(empty($cat3))){
     array_push($a,$cat3);
}

if(!(empty($cat4))){
     array_push($a,$cat4);
}
$c = count($a);
echo $c;
foreach($a as $val) {
    echo "it is here";
    $sql = "INSERT INTO worker_cat_assoc (category_id, worker_id) VALUES ('$val','$id')";
    $results = mysqli_query($connect, $sql);
}

$sql2 = "UPDATE worker SET isActive = 1 , isFirst = 0 WHERE worker_id ="."'$id'" ;

$results2 = mysqli_query($connect,$sql2);

if($results && $results2) {
    echo "Data added successfully";
}

unset($a);
$a = array();






?>