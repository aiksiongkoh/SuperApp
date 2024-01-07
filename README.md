How to clone SuperApp in Pharo

SuperApp is a work in progress. 
It is code ported from a Visualworks motion simulator
https://ar-cad.com
It is the start of Digital Twin applied to Software
https://askoh.com/twin/DigitalTwinsCppSt20230620.pdf

Install Pharo
https://pharo.org
https://pharo.org/download
Download Pharo Launcher
	Click/Windows icon
In FileExplorer
	Look for "C:\Users\askoh\Downloads\pharo-launcher-3.0.1.msi"
	DoubleClick/pharo-launcher-3.0.1.msi
		Accept all defaults to install.
			Beware the installer and Pharo Launcher does not work well with non defaults
In Windows Start icon
	Launch PharoLauncher
In PharoLauncher
	Click/New
	  Select/Official Distribution/Pharo 11.0 - 64bit (stable)
	  Enter Image name:/Pharo11SuperApp
	  Click/Create image
	Select/Pharo11SuperApp
	Click/Launch
In Pharo
	Click/Sources/Git Repositories Browser
		Click/Add
			Click/Clone from github.com
				Enter Owner name/aiksiongkoh
				Enter Project name/SuperApp
				Select Protocol/HTTPS
				Click/OK
		DoubleClick/SuperApp
			Select/VWCompatibility
			RightClick/Load
			Repeat in alphabatical order until StCAD-Basic
			Then StCAD-Math
			StCAD-UI
			StCAD-Geo
			StCAD-MbD
			StCAD-Misc
			StCAD-NMT
			StCAD-STEP
	Click/Browse/System Browser
		to view loaded code
