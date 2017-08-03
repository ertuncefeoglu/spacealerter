Get-WmiObject Win32_LogicalDisk -ComputerName localhost -Filter "DeviceID='C:'" | 
    Foreach-Object {if( ($_.freespace/$_.size) -le (0.1) ) 
    {
        $anonUsername = "anonymous"
        $anonPassword = ConvertTo-SecureString -String "anonymous" -AsPlainText -Force
        $anonCredentials = New-Object System.Management.Automation.PSCredential($anonUsername,$anonPassword)

        $messageParameters = @{                         
                Subject = "Sunucu hard disk doluluk"                         
                Body = "Sunucu doluluğu kritik seviyede!!!"
                #From = "muhammet.avinc@sabah.com.tr"
                To = "ertunc.efeoglu@sabah.com.tr" 
                #CC = "Email name2 <Email.name2@domainname.com>" 
                #Attachments = (Get-ChildItem \\Servername\ServerStorageReport\DiskReport\*.* | sort LastWriteTime | select -last 1)                    
                SmtpServer = "mail.tmgrup.com.tr"                         
      }  
Send-MailMessage -From "obs@tdp.com.tr" @messageParameters -BodyAsHtml -credential $anonCredentials } else {write-host "Hata yok" -foregroundcolor White -backgroundcolor Red } }