<?php 
include "config.php";

$json = file_get_contents('php://input');
$obj = json_decode($json,true);
$searchEmail = $obj["searchEmail"];
$searchPassword = $obj["searchPassword"];

$data["error"] =false;
$data["message"] = "";
$data["success"] = false;
$data["error2"] = false;
$data["message2"]="";
$data["success"]= true;


$sql = "SELECT usertype_id,isValidated,isActive,isFirst,worker_id, worker_lname, worker_fname, worker_dob, worker_zone, worker_barangay,worker_city,doc_id, worker_username, worker_password FROM worker WHERE worker_email ="."'$searchEmail'"." OR worker_username ="."'$searchEmail'";

$result = mysqli_query($connect,$sql);
if($result->num_rows >0){
	while($row = $result->fetch_assoc()) {
	if($searchPassword == $row['worker_password']){
	    $data["success"] = true;
		$data["usertype"] = $row['usertype_id'];
		$data["validate"] = $row['isValidated'];
		$data["activity"] = $row['isActive'];
		$data["first"] = $row['isFirst'];
		$data["uid"] = $row['worker_id'];
		$data["lastname"] = $row['worker_lname'];
		$data["firstname"] = $row['worker_fname'];
		$data["birthdate"] = $row['worker_dob'];
		$data["zone"] = $row['worker_zone'];
		$data["barangay"] = $row['worker_barangay'];
		$data["city"] = $row['worker_city'];
		$data["docId"] = $row['doc_id'];
		$data["username"] = $row['worker_username'];	
	
		
	}
	
	else{

		$data["error"] = true;
		$data["message"] = "Your Password is incorrect.";
	}
	}
	


}else{
	$data["error"]= true;
	$data["message"] = "No email or username found.";
	
}


$sql2 = "SELECT customer_id,usertype_id, isValidated, isActive, customer_lname, customer_fname, customer_dob, customer_zone, customer_barangay, customer_city, customer_username, customer_password FROM customer WHERE customer_email ="."'$searchEmail'"." OR customer_username ="."'$searchEmail'";

$result2 = mysqli_query($connect,$sql2);

if($result2->num_rows >0){
   
	while($row = $result2->fetch_assoc()) {
	if($searchPassword == $row['customer_password']){
	   	$data["success2"] = true;
		$data["usertype"] = $row['usertype_id'];
		$data["validate"] = $row['isValidated'];
		$data["first"] = $row['customer_id'];
		$data["activity"] = $row['isActive'];
		$data["uid"] = $row['customer_id'];
		$data["lastname"] = $row['customer_lname'];
		$data["firstname"] = $row['customer_fname'];
		$data["birthdate"] = $row['customer_dob'];
		$data["zone"] = $row['customer_zone'];
		$data["barangay"] = $row['customer_barangay'];
		$data["city"] = $row['customer_city'];
		$data["docId"] = $row['customer_id'];
		$data["username"] = $row['customer_username'];	
		
	
		
	}else{

		$data["error2"] = true;
		$data["message2"] = "Your Password is incorrect.";
	}
	}



}else{
	$data["error2"]= true;
	$data["message2"] = "No email or username found.";
	
}

echo json_encode($data);

	
$connect->close();
return;


?>