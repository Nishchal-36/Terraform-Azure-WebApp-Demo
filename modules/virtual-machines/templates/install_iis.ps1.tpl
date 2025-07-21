# Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create custom HTML content
$html = @"
<!DOCTYPE html>
<html>
<head>
  <title>Azure WebApp Demo</title>
  <style>
    body {
      margin: 0;
      height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: white;
    }
    h1 {
      font-size: 3rem;
      text-align: center;
      margin-bottom: 2rem;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
    .container {
      text-align: center;
      padding: 2rem;
      background: rgba(255,255,255,0.1);
      border-radius: 20px;
      backdrop-filter: blur(10px);
      box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
    }
    .server-info {
      margin-top: 2rem;
      font-size: 1.2rem;
      opacity: 0.8;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>${message}</h1>
    <div class="server-info">
      <p>Server: $env:COMPUTERNAME</p>
      <p>Powered by Azure & Terraform</p>
    </div>
  </div>
</body>
</html>
"@

# Write the HTML file
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $html

# Restart IIS to ensure changes take effect
iisreset
