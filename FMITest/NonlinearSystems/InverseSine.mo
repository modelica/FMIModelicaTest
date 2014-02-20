within FMITest.NonlinearSystems;
package InverseSine
  "Test of the connection of a Sine with a Ramp block leading to a nonlinear system of equations (the output of a Sine should move according to a ramp)"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-2,14},{-56,46}})));
    Modelica.Blocks.Math.Sin sin
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    Modelica.Blocks.Sources.Ramp ramp(
      duration=0.5,
      offset=0.09,
      height=0.9)
      annotation (Placement(transformation(extent={{40,20},{20,40}})));
  equation
    connect(inverseBlockConstraints.y2, sin.u) annotation (Line(
        points={{-51.95,30},{-42,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sin.y, inverseBlockConstraints.u2) annotation (Line(
        points={{-19,30},{-7.4,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ramp.y, inverseBlockConstraints.u1) annotation (Line(
        points={{19,30},{0.7,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.8));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-2,14},{-56,46}})));
    FMUModels.Sine sin
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    FMUModels.Ramp ramp(
      duration=0.5,
      offset=0.09,
      height=0.9)
      annotation (Placement(transformation(extent={{40,20},{20,40}})));
  equation
    connect(inverseBlockConstraints.y2, sin.u) annotation (Line(
        points={{-51.95,30},{-42,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sin.y, inverseBlockConstraints.u2) annotation (Line(
        points={{-19,30},{-7.4,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ramp.y, inverseBlockConstraints.u1) annotation (Line(
        points={{19,30},{0.7,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.8));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-2,14},{-56,46}})));
    FMUModels.Sine sin
      annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
    FMUModels.Ramp ramp(
      duration=0.5,
      offset=0.09,
      height=0.9)
      annotation (Placement(transformation(extent={{40,20},{20,40}})));
  equation
    connect(inverseBlockConstraints.y2, sin.u) annotation (Line(
        points={{-51.95,30},{-42,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sin.y, inverseBlockConstraints.u2) annotation (Line(
        points={{-19,30},{-7.4,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ramp.y, inverseBlockConstraints.u1) annotation (Line(
        points={{19,30},{0.7,30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=0.8));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model Sine
      extends Modelica.Blocks.Math.Sin;
      annotation (Icon(graphics={Text(
                  extent={{-84,-56},{24,-88}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end Sine;

    model Ramp
      extends Modelica.Blocks.Sources.Ramp;
      annotation (Icon(graphics={Text(
                  extent={{-44,84},{64,52}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end Ramp;
  end FMUModels;
  annotation (preferredView="Info");
end InverseSine;
