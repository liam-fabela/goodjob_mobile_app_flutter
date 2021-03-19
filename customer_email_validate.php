<?PHP
include "config.php";

$json = file_get_contents('php://input');
$obj = json_decode($json,true);
$searchEmail = $obj["searchEmail"];
$searchUsername =$obj["searchUsername"];


$data["error"] =false;
$data["message"] = "";
$data["message2"]="";
$data["error2"] = false;
$data["success"] = false;



$sql = "SELECT customer_email, customer_username FROM customer WHERE customer_email ="."'$searchEmail'"." or customer_username ="."'$searchUsername'";

$result = mysqli_query($connect,$sql);
if($result->num_rows >0){
	while($row = $result->fetch_assoc()) {
		if($searchEmail == $row['customer_email']){
		$data["error"] = true;
		$data["message"] = "email address already in use.";
	}
		if($searchUsername == $row['customer_username']){
		$data[	"error2"] = true;
		$data["message2"] = "username already in use.";
	}
	}
    }else{

	$data["success"] = true;
	
}


echo json_encode($data);

	
$connect->close();
return;




?>