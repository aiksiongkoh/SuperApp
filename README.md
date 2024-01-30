# How to clone SuperApp in Pharo
   
SuperApp is a work in progress   
It is code ported from a Visualworks Smalltalk [motion simulator](https://ar-cad.com)   
Its goal is to be a full 3D CAD with Motion Simulation.   
It is the start of [Digital Twin applied to Software](https://askoh.com/index.html#DigitalTwinS)   
The motion simulator has been translated to C++ as open source [OndselSolver](https://github.com/Ondsel-Development/OndselSolver).   

Install [Pharo](https://pharo.org)  
[Download Pharo Launcher](https://pharo.org/download)  
&emsp;Click/Windows icon  
&emsp;Click/Save As  
&emsp;Select/Downloads folder  
&emsp;Click/Save  
In Windows FileExplorer  
&emsp;Look for "C:\Users\askoh\Downloads\pharo-launcher-3.0.1.msi"  
&emsp;DoubleClick/pharo-launcher-3.0.1.msi  
&emsp;&emsp;Accept all defaults to install  
&emsp;&emsp;&emsp;Beware the installer and Pharo Launcher does not work well with non defaults  
In Windows Start icon  
&emsp;Launch PharoLauncher  
In PharoLauncher  
&emsp;Click/New  
&emsp;&emsp;Select/Official Distribution/Pharo 11.0 - 64bit (stable)  
&emsp;&emsp;Enter Image name:/Pharo11SuperApp  
&emsp;&emsp;Click/Create image  
&emsp;Select/Pharo11SuperApp  
&emsp;Click/Launch  
In Pharo  
&emsp;Open a Playground and execute:

```st
Metacello new
	repository: 'github://aiksiongkoh/SuperApp:main/src';
	baseline: 'SuperApp';
	load
```

&emsp;Click/Browse/System Browser  
&emsp;&emsp;to view loaded code  
