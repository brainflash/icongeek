<?php
// echo 'OK, response UUID: 6b9efd8a-def0-6f40-7195-8722b7138ec9';

class UUID {
  public static function v4() {
    return sprintf('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',

      // 32 bits for "time_low"
      mt_rand(0, 0xffff), mt_rand(0, 0xffff),

      // 16 bits for "time_mid"
      mt_rand(0, 0xffff),

      // 16 bits for "time_hi_and_version",
      // four most significant bits holds version number 4
      mt_rand(0, 0x0fff) | 0x4000,

      // 16 bits, 8 bits for "clk_seq_hi_res",
      // 8 bits for "clk_seq_low",
      // two most significant bits holds zero and one for variant DCE1.1
      mt_rand(0, 0x3fff) | 0x8000,

      // 48 bits for "node"
      mt_rand(0, 0xffff), mt_rand(0, 0xffff), mt_rand(0, 0xffff)
    );
  }
}

function saveFile($uuid) {
	$filePath = "../upload/$uuid.mobileconfig";
	$file = @fopen($filePath, 'w');
	$err = null;
	if ($file === FALSE) {
		$err = error_get_last();
	} else {
		$data = array_values($_POST)[0];
		$bytes = @fwrite($file, $data);
		if ($bytes === FALSE) {
			$err = error_get_last();
		}
		@fclose($file);
	}
	if ($err !== null) {
		return '{ "status": "ERR", "error": "' . $err['message'] . '"}';
	}
	
	// TODO: sign the config file and save to downloads folder
		
	return '{ "status": "OK", "uuid": "' . $uuid . '" }';
}

$uniqueID = strtoupper(UUID::v4());
$result = saveFile($uniqueID);
echo $result;

// echo '$POST: ' . var_dump($_POST) . '<br><br>';
// echo array_values($_POST)[0];
echo $_POST['file1'];

?>
