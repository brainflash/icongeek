<?php

function signConfig($filename) {
	$inputFile = "./$filename.mobileconfig";
	$outputFile = "../download/$filename.mobileconfig";
	$sslPath = './ssl';
	$command = "openssl smime -sign -signer ".$sslPath."/certificate.crt -inkey ".$sslPath."/private.key -certfile ".$sslPath."/ca_bundle.crt -nodetach -outform der -in ".$inputFile." -out ".$outputFile;
// 	echo $command;
	$output = shell_exec($command);

//	$output = shell_exec("openssl smime -sign -in $filePath 2>&1");
// 	echo '<pre>$data: ' . $output . '</pre>';
}

signConfig('sign_test');

// signConfig('FD35C475-0205-4692-9E6C-D3E6E7B5D6E7');

// echo '$POST: ' . var_dump($_POST) . '<br><br>';
// echo array_values($_POST)[0];
// echo $_POST['file1'];

?>
