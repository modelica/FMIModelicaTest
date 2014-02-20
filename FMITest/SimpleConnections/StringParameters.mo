within FMITest.SimpleConnections;
package StringParameters
  "Connection of one FMU with a source, and the FMU has a String parameter holding a file name and a file is read into the FMU"
  extends Modelica.Icons.ExamplesPackage;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    import ModelicaServices.ExternalReferences.loadResource;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    FMUModels.InertiaFromFile inertiaFromFile(file=loadResource(
          "modelica://FMITest/Resources/Data/data_inertia1.txt"))
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  equation
    connect(sine.y, inertiaFromFile.tau) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    import ModelicaServices.ExternalReferences.loadResource;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    FMUModels.InertiaFromFile inertiaFromFile(file=loadResource(
          "modelica://FMITest/Resources/Data/data_inertia1.txt"))
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  equation
    connect(sine.y, inertiaFromFile.tau) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model InertiaFromFile
      import SI = Modelica.SIunits;
      import Modelica.Utilities.Examples.readRealParameter;
      extends Modelica.Blocks.Interfaces.BlockIcon;

      parameter String file="noFileDefined" "File on which data is present"
        annotation (Dialog(__Dymola_loadSelector(filter="Text files (*.txt)",
              caption=
                "Open text file to read parameters of the form \"name = value\"")));
      final parameter SI.Inertia J=readRealParameter(file, "J") "Inertia";
      final parameter SI.Angle phi_rel0=readRealParameter(file, "phi_rel0")
        "Relative angle";
      final parameter SI.AngularVelocity w_rel0=readRealParameter(file,
          "w_rel0") "Relative angular velocity";

      Modelica.Mechanics.Rotational.Components.Inertia inertia(
        J=J,
        phi(fixed=true, start=phi_rel0),
        w(fixed=true, start=w_rel0))
        annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
      Modelica.Blocks.Interfaces.RealInput tau
        "Accelerating torque acting at flange (= -flange.tau)"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      connect(torque.flange, inertia.flange_a) annotation (Line(
          points={{-12,0},{-2,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(torque.tau, tau) annotation (Line(
          points={{-34,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Documentation(info="<html>
<p>
Model that shows the usage of Examples.readRealParameter and Examples.expression.
The model has 3 parameters and the values of these parameters are read
from a file.
</p>
</html>"),
        experiment(StopTime=1.01),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-222,-112},{216,-140}},
              lineColor={0,0,0},
              textString="file=%file"), Text(
              extent={{-76,-56},{80,-84}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end InertiaFromFile;

  end FMUModels;
  annotation (preferredView="Info", Documentation(info="<html>
<p>
The following issues are checked with this test model:
</p>

<ul>
<li> Support for String parameters, so it is possible to set a parameter of type String 
     for an FMU instance. In the test model, a file name must be defined.</li>

<li> Support for reading data from a file. The difficult part is that the file to be read
     must be identified when exporting the FMU and this file has to be stored inside the
     FMU, and when importing the FMU, this file has to be read during importing
     or during initialization. </li>
</ul>
</html>"));
end StringParameters;
