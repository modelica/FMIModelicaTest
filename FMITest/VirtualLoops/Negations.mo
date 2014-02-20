within FMITest.VirtualLoops;
package Negations
  "Series connection of \"not\" blocks that are structured so that an artificial loops is present with FMUs"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends Modelica.Icons.Example;
    parameter Boolean Qini=false "Start value of Q at initial time";
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.5)
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    Modelica.Blocks.Logical.Not not2
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Logical.Not not3
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    Modelica.Blocks.Logical.Not not4
      annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{52,-40},{72,-20}})));
  equation

    connect(booleanPulse.y, not1.u) annotation (Line(
        points={{-59,10},{-42,10}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, not2.u) annotation (Line(
        points={{-19,10},{-2,10}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not2.y, not3.u) annotation (Line(
        points={{21,10},{34,10},{34,-10},{-52,-10},{-52,-30},{-42,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not3.y, not4.u) annotation (Line(
        points={{-19,-30},{-2,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not4.y, y) annotation (Line(
        points={{21,-30},{62,-30}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.5)
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    FMUModels.ParallelNot1 parallelNot1
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    FMUModels.ParallelNot2 parallelNot2
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{54,-4},{74,16}})));
  equation
    connect(booleanPulse.y, parallelNot1.u1) annotation (Line(
        points={{-59,10},{-52,10},{-52,14},{-42,14}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot1.y1, parallelNot2.u1) annotation (Line(
        points={{-19,14},{-2,14}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot2.y1, parallelNot1.u2) annotation (Line(
        points={{21,14},{28,14},{28,14},{40,14},{40,-16},{-52,-16},{-52,6},{-42,
            6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot1.y2, parallelNot2.u2) annotation (Line(
        points={{-19,6},{-2,6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot2.y2, y) annotation (Line(
        points={{21,6},{64,6}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=0.5)
      annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
    FMUModels.ParallelNot1 parallelNot1
      annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
    FMUModels.ParallelNot2 parallelNot2
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{54,-4},{74,16}})));
  equation
    connect(booleanPulse.y, parallelNot1.u1) annotation (Line(
        points={{-59,10},{-52,10},{-52,14},{-42,14}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot1.y1, parallelNot2.u1) annotation (Line(
        points={{-19,14},{-2,14}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot2.y1, parallelNot1.u2) annotation (Line(
        points={{21,14},{40,14},{40,-16},{-52,-16},{-52,6},{-42,6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot1.y2, parallelNot2.u2) annotation (Line(
        points={{-19,6},{-2,6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(parallelNot2.y2, y) annotation (Line(
        points={{21,6},{64,6}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=2));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    block ParallelNot1
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));
      Modelica.Blocks.Logical.Not not3
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      Modelica.Blocks.Interfaces.BooleanInput u1
        "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      Modelica.Blocks.Interfaces.BooleanInput u2
        "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y1
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      Modelica.Blocks.Interfaces.BooleanOutput y2
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    equation
      connect(not1.u, u1) annotation (Line(
          points={{-12,40},{-120,40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not3.u, u2) annotation (Line(
          points={{-12,-40},{-120,-40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not1.y, y1) annotation (Line(
          points={{11,40},{110,40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not3.y, y2) annotation (Line(
          points={{11,-40},{110,-40}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Bitmap(extent={{-90,92},{88,-68}}, fileName=
              "modelica://FMITest/Resources/Images/ParallelNot1.png"),Text(
                  extent={{-54,-66},{54,-98}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end ParallelNot1;

    block ParallelNot2
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Logical.Not not2
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));
      Modelica.Blocks.Logical.Not not4
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      Modelica.Blocks.Interfaces.BooleanInput u1
        "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      Modelica.Blocks.Interfaces.BooleanInput u2
        "Connector of Boolean input signal"
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y1
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,30},{120,50}})));
      Modelica.Blocks.Interfaces.BooleanOutput y2
        "Connector of Boolean output signal"
        annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    equation
      connect(not2.u, u1) annotation (Line(
          points={{-12,40},{-120,40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not4.u, u2) annotation (Line(
          points={{-12,-40},{-120,-40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not2.y, y1) annotation (Line(
          points={{11,40},{110,40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(not4.y, y2) annotation (Line(
          points={{11,-40},{110,-40}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Bitmap(extent={{-90,92},{88,-68}}, fileName=
              "modelica://FMITest/Resources/Images/ParallelNot1.png"),Text(
                  extent={{-54,-66},{54,-98}},
                  lineColor={135,135,135},
                  fillColor={235,245,255},
                  fillPattern=FillPattern.Solid,
                  textString="to FMU")}));
    end ParallelNot2;
  end FMUModels;
  annotation (preferredView="Info");
end Negations;
