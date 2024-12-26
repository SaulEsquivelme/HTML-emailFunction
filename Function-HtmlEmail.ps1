$emailDate= (Get-Date).ToString('MM/dd/yyyy')
$computerName = $env:computername

function Function-HtmlEmail ($subject, $to, $body, $attach){
    $BodyHTML = @"
    <html>
    <h3>$subject</h3>
    <div>
    <body>
    $body
    </body>
    <br></br>
<pre>
Generation date - $emailDate
Script ran from - $computerName
</pre>
    </html>
"@

    $mailParams = @{
        SmtpServer = "smtp-server.companydomain.com"
        to         = $to
        from       = "no-reply@companydomain.com"
        Subject    = "Automation - "+$subject
        Body       = $BodyHtml
        BodyAsHtml = $true    
    }

    if ($attach -ne $none){
        $mailParams += @{
        Attachment = $attach
        }
}

Send-MailMessage @mailParams
}

##Use cases
<#
#1st use case, simplest call
#Function-HtmlEmail "subject" "user.lastname@companydomain.com" "body 2" $none
#Function-HtmlEmail "subject" "user.lastname@companydomain.com" "body 2" "C:\Users\User1\Temp\file1.txt"

#2nd use case, array to HTML body call
$subject = "test"
$emailTo = "user.lastname@companydomain.com"
$myArray = @("Item 1", "Item 2", "Item 3")
$EmailBody = $myArray -join '<br/>'
$bodyHTML = ConvertTo-Html -Body $EmailBody
Function-HtmlEmail $subject $emailTo $bodyHTML $none

#3rd case, multiple attachments, multiple emailTo, different format section
$Function_HtmlTemplateLocation = "\\companydomain.com\Folder1\Function-html-email.ps1"
.$Function_HtmlTemplateLocation
$emailTo = ("email_1@complanydomain.com","email_2@complanydomain.com")
$results = @()	
$body += "This is a sample text.</b>"
$textFile = Get-Content $fileReferral
$textLines = $textFile -split "\n"
    foreach ($line in $textLines){
    $newLine = $line.split(",")[0,1] -join ":"
    $newLine
    $results += $newLine 
}
    $results = $results -join '<br/>' 
    $results = "<span style='font-size:12px;'>" + $results + "</span>"
    $body += $results
	$EmailBody = $body -join '<br/>'
	$bodyHTML = ConvertTo-Html -Body $EmailBody 
	$subject = "WARNING - Snapshot Errors"
	Function-HtmlEmail $subject $emailTo $bodyHTML ($fileReferral,$anotherSampleFile)
#> 

