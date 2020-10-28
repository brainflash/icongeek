<?php
class UUID {
  public static function v4() {
    return sprintf('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
      mt_rand(0, 0xffff), mt_rand(0, 0xffff),
      mt_rand(0, 0xffff),
      mt_rand(0, 0x0fff) | 0x4000,
      mt_rand(0, 0x3fff) | 0x8000,
      mt_rand(0, 0xffff), mt_rand(0, 0xffff), mt_rand(0, 0xffff)
    );
  }
}

function signConfig($filename) {
	$inputFile = "./$filename.mobileconfig";
	$outputFile = "../dl/$filename.mobileconfig";
//	$sslPath = './ssl';
	$sslPath = '../../../var/icongeek/ssl';
	$command = "openssl smime -sign -signer ".$sslPath."/certificate.crt -inkey ".$sslPath."/private.key -certfile ".$sslPath."/ca_bundle.crt -nodetach -outform der -in ".$inputFile." -out ".$outputFile;
	$output = shell_exec($command);
}

function saveFile($uuid) {
	$filePath = "./$uuid.mobileconfig";
	$file = @fopen($filePath, 'w');
	$err = null;
	if ($file === FALSE) {
		$err = error_get_last();
	} else {
		$data = $_POST['file1'];
		$bytes = @fwrite($file, $data);
		if ($bytes === FALSE) {
			$err = error_get_last();
		}
		@fclose($file);
	}
	if ($err !== null) {
		return '{ "status": "ERR", "error": "' . $err['message'] . '"}';
	}
	
	signConfig($uuid);
		
	return '{ "status": "OK", "uuid": "' . $uuid . '" }';
}

if (isset($_POST['file1']) === false) {
	exit();
}

$uniqueID = strtoupper(UUID::v4());
$result = saveFile($uniqueID);

header('Content-type: application/json');
echo $result;
?>
