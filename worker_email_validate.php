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



$sql = "SELECT worker_email, worker_username FROM worker WHERE worker_email ="."'$searchEmail'"." or worker_username ="."'$searchUsername'";

$result = mysqli_query($connect,$sql);
if($result->num_rows >0){
	while($row = $result->fetch_assoc()) {
		if($searchEmail == $row['worker_email']){
		$data["error"] = true;
		$data["message"] = "email address already in use.";
	}
		if($searchUsername == $row['worker_username']){
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