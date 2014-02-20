within FMITest.SimpleConnections;
package SeriesWithEnumerations2
  "Simple series connection of two FMUs with envolved enumerations from the Modelica.Electrical.Digital library that are propagated and are time/value transformed"
  extends Modelica.Icons.ExamplesPackage;

  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Electrical.Digital.Sources.Pulse pulse(
      width=40,
      period=0.5,
      startTime=0.1,
      pulse=Modelica.Electrical.Digital.Interfaces.Logic.'1',
      quiet=Modelica.Electrical.Digital.Interfaces.Logic.'0',
      nperiod=-1)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Electrical.Digital.Gates.InvGate invGate1(
      tLH=0.1,
      tHL=0.1,
      G2(y(start=invGate1.y0,fixed=true)))
      annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
    Modelica.Electrical.Digital.Gates.InvGate invGate2(
      tLH=0.1,
      tHL=0.1,
      G2(y(start=invGate2.y0,fixed=true)))
      annotation (Placement(transformation(extent={{-2,0},{18,20}})));
  equation
    connect(pulse.y, invGate1.x) annotation (Line(
        points={{-40,10},{-26,10}},
        color={127,0,127},
        smooth=Smooth.None));
    connect(invGate1.y, invGate2.x) annotation (Line(
        points={{-10,10},{2,10}},
        color={127,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    Modelica.Electrical.Digital.Sources.Pulse pulse(
      width=40,
      period=0.5,
      startTime=0.1,
      pulse=Modelica.Electrical.Digital.Interfaces.Logic.'1',
      quiet=Modelica.Electrical.Digital.Interfaces.Logic.'0',
      nperiod=-1)
      annotation (Placement(transformation(extent={{-58,0},{-38,20}})));
    FMUModels.InvGate1 invGate1
      annotation (Placement(transformation(extent={{-26,0},{-6,20}})));
    FMUModels.InvGate2 invGate2
      annotation (Placement(transformation(extent={{4,0},{24,20}})));
  equation
    connect(pulse.y, invGate1.x) annotation (Line(
        points={{-38,10},{-22,10}},
        color={127,0,127},
        smooth=Smooth.None));
    connect(invGate1.y, invGate2.x) annotation (Line(
        points={{-6,10},{8,10}},
        color={127,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    Modelica.Electrical.Digital.Sources.Pulse pulse(
      width=40,
      period=0.5,
      startTime=0.1,
      pulse=Modelica.Electrical.Digital.Interfaces.Logic.'1',
      quiet=Modelica.Electrical.Digital.Interfaces.Logic.'0',
      nperiod=-1)
      annotation (Placement(transformation(extent={{-58,0},{-38,20}})));
    FMUModels.InvGate1 invGate1
      annotation (Placement(transformation(extent={{-26,0},{-6,20}})));
    FMUModels.InvGate2 invGate2
      annotation (Placement(transformation(extent={{4,0},{24,20}})));
  equation
    connect(pulse.y, invGate1.x) annotation (Line(
        points={{-38,10},{-22,10}},
        color={127,0,127},
        smooth=Smooth.None));
    connect(invGate1.y, invGate2.x) annotation (Line(
        points={{-6,10},{8,10}},
        color={127,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model InvGate1
      extends Modelica.Electrical.Digital.Gates.InvGate(
        tLH=0.1,
        tHL=0.1,
        G2(y(start=Modelica.Electrical.Digital.Interfaces.Logic.'U',fixed=true)));
      annotation (Icon(graphics={Text(
              extent={{-66,-24},{68,-52}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end InvGate1;

    model InvGate2
      extends Modelica.Electrical.Digital.Gates.InvGate(
        tLH=0.1,
        tHL=0.1,
        G2(y(start=Modelica.Electrical.Digital.Interfaces.Logic.'U',fixed=true)));
      annotation (Icon(graphics={Text(
              extent={{-64,-28},{70,-56}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end InvGate2;
  end FMUModels;
  annotation (preferredView="Info");
end SeriesWithEnumerations2;
