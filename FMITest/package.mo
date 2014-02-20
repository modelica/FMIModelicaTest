within ;
package FMITest "Library of models to test connected FMUs in a Modelica tool"
extends Modelica.Icons.Package;


annotation (preferredView="Info", uses(Modelica(version="3.2")), Documentation(info="<html>
<p>
Library <b>FMITest</b> is a Modelica package
providing models to test connected FMUs (Functional Mockup Units), especially
during <b>event iteration</b> and during <b>initializaton</b>.
The connection classes are structured in packages in different categories according to the underlying
basic difficulty (such as \"package LinearSystems: linear systems of equations occur over the connected FMUs\").
</p>

<p>
All examples are organized in packages. The details of an example are given in the package description text or package documentation but not in the models in the package. Every package has the following structure:
</p>

<ul>
<li> <b>Reference</b> is the underlying Modelica model that shall be simulated and that
     can be successfully simulated in a Modelica tool.<br> &nbsp;</li>
<li> <b>WithFMUsReference</b> is the same model as <b>Reference</b> but it is re-structured
     so that the structure corresponds to the one when replacing some of the components with FMUs.
     These are still pure Modelica models and should simulate successfully in any Modelica tool.
     The components of this model that shall be exported as FMUs are store in the sub-package
     <b>FMUModels</b>. All models stored here shall be exported as FMUs.<br> &nbsp;</li>
<li> <b>WithFMUs</b> is the same model as <b>WithFMUsReference</b> but some of the component
     instances (marked in the icon with the text \"toFMU\") are replaced by imported FMUs.
     Since importing is tool dependent, the version on the svn server just provides a copy
     of <b>WithFMUsReference</b> at this place and the tester has to replace the marked
     component instances with FMUs imported with the underlying used tool.</li>
</ul>

<p>
<br><b>Licensed by DLR under the Modelica License 2</b><br>
<b>Copyright &copy; 2013, DLR Institute of System Dynamics and Control</b
</p>

<p>
<i>This Modelica package is <u>free</u> software and
the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty) at
<a href=\"http://www.Modelica.org/licenses/ModelicaLicense2\">
http://www.Modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"));
end FMITest;
