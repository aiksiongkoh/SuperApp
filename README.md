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
&emsp;Click/Browse/Playground/  
&emsp;Enter text below:  
&emsp;Metacello new  
&emsp;&emsp;repository: 'github://aiksiongkoh/SuperApp';  
&emsp;&emsp;baseline: 'SuperApp';  
&emsp;&emsp;load  
&emsp;Select text above and RightClick/Do it/  
&emsp;If debugger complains of missing classes, Click/Proceed/  
