within FMITest.SimpleConnections;
package Series1
  "Simple series connection of two FMUs consisting of a gain per FMU"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Math.Gain gain1(k=2)
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Math.Gain gain2(k=3)
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
  equation
    connect(sine.y, gain1.u) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain1.y, gain2.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    FMUModels.Gain1 gain1(k=2)
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.Gain2 gain2(k=3)
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
  equation
    connect(sine.y, gain1.u) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain1.y, gain2.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    FMUModels.Gain1 gain1(k=2)
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.Gain2 gain2(k=3)
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
  equation
    connect(sine.y, gain1.u) annotation (Line(
        points={{-39,10},{-22,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain1.y, gain2.u) annotation (Line(
        points={{1,10},{18,10}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=1.1));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;
    model Gain1
      extends Modelica.Blocks.Math.Gain;
      annotation (Icon(graphics={Text(
                  extent={{-84,14},{24,-18}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end Gain1;

    model Gain2
      extends Modelica.Blocks.Math.Gain;
      annotation (Icon(graphics={Text(
                  extent={{-92,16},{16,-16}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end Gain2;
  end FMUModels;
  annotation (preferredView="Info");
end Series1;
