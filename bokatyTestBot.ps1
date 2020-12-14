<# 
.SYNOPSIS 
bokaty_test_bot.ps1 - Тестируем возможности телеграм бота 
 
.DESCRIPTION  
Тестируем возможности телеграм бота 
 
.OUTPUTS 
Results are printed to the console. Future releases will support outputting to a log file.  
 
.NOTES 
Written by: Aleksey Bokaty
 
Find me on: 
 
* My email: a.bokaty@gmail.com   
* Github:  https://github.com/Alexe70   
 
Change Log 
V1.00, 12/08/2020 - Initial version 
 
#>

[string] $botTocken = Get-Content -Path .\BotTocken #Получаем токен бота из файла

#region объявляем класс веб сервера

$http = [System.Net.HttpListener]::new()
$Http.Prefixes.Add("https://192.168.88.2:8443/")
$Http.Prefixes.Add("http://192.168.88.2:80/")
$http.Start()
#endregion

function webServer {
    #param (
    #    OptionalParameters
    #)
    
}

while ($http.IsListening) {

    # Get Request Url
    # When a request is made in a web browser the GetContext() method will return a request object
    # Our route examples below will use the request object properties to decide how to respond
    $context = $http.GetContext()

    if ($context.Request.HttpMethod -eq 'GET' -and $context.Request.RawUrl -eq '/') {

        # We can log the request to the terminal
        write-host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -f 'mag'

        # the html/data you want to send to the browser
        # you could replace this with: [string]$html = Get-Content "C:\some\path\index.html" -Raw
        [string]$html = "<h1>A Powershell Webserver</h1><p>home page</p>" 
        
        #resposed to the request
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($html) # convert htmtl to bytes
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length) #stream to broswer
        $context.Response.OutputStream.Close() # close the response
    
    }
}