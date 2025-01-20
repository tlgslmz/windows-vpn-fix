# Windows VPN Fix Script

This PowerShell script resolves VPN and internet access issues caused by IP conflict between home and company networks (Windows 11 24H2 update). 

## Usage
1. Stop Check Point services.
2. Back up and modify the `trac.defaults` file.
3. Restart the services.

## PowerShell Code
The script is available in the repository as `vpn-fix.ps1`.

## Related Article
For more details, check [Check Point SK182749](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk182749).
