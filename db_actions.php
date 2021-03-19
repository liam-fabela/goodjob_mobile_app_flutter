<?php
include "config.php";


    $json = file_get_contents('php://input');
    $obj = json_decode($json,true);
    $action = $obj["action"];
    
if("ADD_WORKER" == $action){
    $lastname = $obj["lastname"];
    $firstname = $obj["firstname"];
    $birthdate = $obj["birthdate"];
    $zone =$obj["zone"];
    $barangay = $obj["barangay"];
    $workerImage = $obj["workerImage"];
    $frontPic = $obj["frontPic"];
    $workerValidFront = $obj["workerValidFront"];
    $frontId =$obj["frontId"];
    $workerValidBack = $obj["workerValidBack"];
    $backId = $obj["backId"];
    $docId = $obj["docId"];
    $workerdocu = $obj["workerdocu"];
    $docPic = $obj["docPic"];
    $username = $obj["username"];
    $email = $obj["email"];
    $password =$obj["password"];
    
  $realImage1 = base64_decode($frontPic);
   $realImage2 = base64_decode($frontId);
  $realImage3 = base64_decode($backId);
   $realImage4 = base64_decode($docPic);
    
   $targetDir = "worker_requirements/";
    
   $targetFilePath1 = $targetDir.$workerImage;
    $targetFilePath2 = $targetDir.$workerValidFront;
   $targetFilePath3 = $targetDir.$workerValidBack;
    $targetFilePath4 = $targetDir.$workerdocu;
    
   file_put_contents($targetFilePath1, $realImage1);
   file_put_contents($targetFilePath2, $realImage2);
    file_put_contents($targetFilePath3, $realImage3);
    file_put_contents($targetFilePath4, $realImage4);
    
    echo "files uploaded!";

    $sql = "INSERT INTO worker(usertype_id,worker_lname, worker_fname, worker_dob, worker_zone, worker_barangay,worker_photo,worker_validIDfront, worker_validIDback, doc_id,worker_docurqr,worker_username,worker_email,worker_password) VALUES (1, '$lastname', '$firstname','$birthdate','$zone','$barangay', '$workerImage', '$workerValidFront',' $workerValidBack', '$docId','$workerdocu', '$username', '$email', '$password')";
    $result = mysqli_query($connect,$sql);
    if($result)
    {
        $MSG = "Worker added successfully";
        $json = json_encode($MSG);
        echo "user added successfully";
    }else{
         $MSG = "Worker not added";
        $json = json_encode($MSG);
    }
    
    $connect->close();
    return;
    }
    
if("ADD_CUSTOMER ==$action") {
    $lastname = $obj["lastname"];
    $firstname = $obj["firstname"];
    $birthdate = $obj["birthdate"];
    $zone =$obj["zone"];
    $barangay = $obj["barangay"];
    $username = $obj["username"];
    $email = $obj["email"];
    $password =$obj["password"];
    
     $sql = "INSERT INTO customer(usertype_id,customer_lname, customer_fname, customer_dob, customer_zone, customer_barangay,customer_username,customer_email,customer_password) VALUES (2, '$lastname', '$firstname','$birthdate','$zone','$barangay','$username', '$email', '$password')";
    $result = mysqli_query($connect,$sql);
    if($result)
    {
        $MSG = "Worker added successfully";
        $json = json_encode($MSG);
        echo "customer added successfully";
    }else{
         $MSG = "Worker not added";
        $json = json_encode($MSG);
    }
    
    $connect->close();
    return;
    
    
    
    
}




?>