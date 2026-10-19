Add-Type -AssemblyName System.Drawing
function MakeIcon($size,$path){
  $bmp = New-Object System.Drawing.Bitmap($size,$size)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.Clear([System.Drawing.Color]::FromArgb(15,13,26))
  $rect = New-Object System.Drawing.Rectangle(0,0,$size,$size)
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect,[System.Drawing.Color]::FromArgb(212,175,106),[System.Drawing.Color]::FromArgb(139,92,246),45)
  $r = [int]($size*0.22)
  $path2 = New-Object System.Drawing.Drawing2D.GraphicsPath
  $path2.AddArc(0,0,$r*2,$r*2,180,90)
  $path2.AddArc($size-$r*2,0,$r*2,$r*2,270,90)
  $path2.AddArc($size-$r*2,$size-$r*2,$r*2,$r*2,0,90)
  $path2.AddArc(0,$size-$r*2,$r*2,$r*2,90,90)
  $path2.CloseFigure()
  $g.FillPath($brush,$path2)
  $font = New-Object System.Drawing.Font("Amiri",$([int]($size*0.55)),[System.Drawing.FontStyle]::Bold)
  $sf = New-Object System.Drawing.StringFormat
  $sf.Alignment = [System.Drawing.StringAlignment]::Center
  $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
  $tb = New-Object System.Drawing.RectangleF(0,0,$size,$size)
  $g.DrawString("م", $font, [System.Drawing.Brushes]::White, $tb, $sf)
  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose(); $bmp.Dispose()
}
MakeIcon 192 "icon-192.png"
MakeIcon 512 "icon-512.png"
MakeIcon 180 "apple-touch-icon.png"
Write-Host "done"
