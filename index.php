<?php

$sampleText = '';
$output = '';

if (isset($_REQUEST['sampleText'])) {
    $sampleText = $_REQUEST['sampleText'];
    if (strlen($sampleText) == 0) {
        $sampleSubmittedText = '<p id="sampleSubmittedText" style="color: red">Sample cannot be blank!</p>';
    } else {
        $sampleSubmittedText = '<p id="sampleSubmittedText" style="color: green">Text sample submitted</p>';

        $fileName = 'sample.txt';
        $filePath = dirname(__FILE__) . "/sample-text/$fileName";
        if (!file_put_contents($filePath, $sampleText)) {
            $sampleSubmittedText = '<p id="sampleSubmittedText" style="color: red;">Error copying text to file!</p>';
        } else {
            $cmd = "./productive_vocab.rb $filePath";
            $output = shell_exec($cmd);
        }
    }
} else {
    $sampleSubmittedText = '<p id="sampleSubmittedText"/>';
}

if (strlen($output) != 0) {
    $outputDiv = "<h3>Results:</h3><div id=\"resultsDiv\"><pre>$output</pre></div>";
} else {
    $outputDiv = '';
}

$html = "

<html>
<head>
<style type=\"text/css\">
body {
    background-color: silver;
}

#sampleText {
    width: 800px;
    height: 400px;
}

#sampleSubmittedText {
    height: 14px;
}

#resultsDiv {
    background-color: white;
    /*padding-left: 40px;*/
    border: 1px solid black;
    width: 400px;
}

</style>
</head>
<body>
    <center>
    <h1>Welcome to the Productive Vocabulary Test!</h1>
    $sampleSubmittedText
    <h3>Enter sample text below</h3>
    <form action=\"\" method=\"POST\">
        <textarea id=\"sampleText\" name=\"sampleText\">$sampleText</textarea>
        <br/>
        <input type=\"submit\" value=\"Submit\"/>
    </form>
    $outputDiv
    </center>
</body>
</html>

";

echo $html;

?>
