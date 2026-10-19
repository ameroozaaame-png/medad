Add-Type -AssemblyName System.Drawing
function MakeIcon($size,$path,$maskable){
  $bmp = New-Object System.Drawing.Bitmap($size,$size)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias
  $g.Clear([System.Drawing.Color]::FromArgb(15,13,26))
  $safe = if($maskable){ [int]($size*0.12) } else { 0 }
  $inner = $size - 2*$safe
  $rect = New-Object System.Drawing.Rectangle($safe,$safe,$inner,$inner)
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect,[System.Drawing.Color]::FromArgb(212,175,106),[System.Drawing.Color]::FromArgb(139,92,246),45)
  $r = [int]($inner*0.22)
  $path2 = New-Object System.Drawing.Drawing2D.GraphicsPath
  $path2.AddArc($safe,$safe,$r*2,$r*2,180,90)
  $path2.AddArc($safe+$inner-$r*2,$safe,$r*2,$r*2,270,90)
  $path2.AddArc($safe+$inner-$r*2,$safe+$inner-$r*2,$r*2,$r*2,0,90)
  $path2.AddArc($safe,$safe+$inner-$r*2,$r*2,$r*2,90,90)
  $path2.CloseFigure()
  $g.FillPath($brush,$path2)
  $font = New-Object System.Drawing.Font("Amiri",$([int]($inner*0.55)),[System.Drawing.FontStyle]::Bold)
  $sf = New-Object System.Drawing.StringFormat
  $sf.Alignment = [System.Drawing.StringAlignment]::Center
  $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
  $tb = New-Object System.Drawing.RectangleF($safe,$safe,$inner,$inner)
  $g.DrawString("م", $font, [System.Drawing.Brushes]::White, $tb, $sf)
  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose(); $bmp.Dispose()
}
MakeIcon 192 "icon-192.png" $false
MakeIcon 512 "icon-512.png" $false
MakeIcon 192 "icon-maskable-192.png" $true
MakeIcon 512 "icon-maskable-512.png" $true
MakeIcon 180 "apple-touch-icon.png" $false
# wide screenshot 1280x720 placeholder (colored canvas with title)
$bmp = New-Object System.Drawing.Bitmap(1280,720)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::FromArgb(15,13,26))
$font = New-Object System.Drawing.Font("Tajawal",$([int]64),[System.Drawing.FontStyle]::Bold)
$g.DrawString("مِداد — منصة الكتابة العربية", $font, [System.Drawing.Brushes]::White, 120, 260)
$g.Dispose(); $bmp.Save("screenshot-wide.png",[System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
$bmp = New-Object System.Drawing.Bitmap(720,1280)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::FromArgb(15,13,26))
$font = New-Object System.Drawing.Font("Tajawal",$([int]56),[System.Drawing.FontStyle]::Bold)
$g.DrawString("مِداد", $font, [System.Drawing.Brushes]::White, 260, 560)
$g.Dispose(); $bmp.Save("screenshot-narrow.png",[System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
Write-Host "done"
